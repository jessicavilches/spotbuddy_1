import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'globals.dart' as globals;

void main() => runApp(Map());

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: FireMap()
        )
    );
  }
}

class FireMap extends StatefulWidget {
  @override
  State createState() => FireMapState();
}



class FireMapState extends State<FireMap> {
  //static String one = 'myID';
  //final Marker _marker = new Marker(markerId: one);





  //Map<MarkerId, Marker> markers = <MarkerId, Marker> {};

  GoogleMapController mapController;


  MarkerId selectedMarker;

  LatLng _lastMapPosition = LatLng(24.150, -110.32);
  Location location = new Location();
  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();

  final Set<Marker> _markers = Set();

  //final Marker one = new Marker()

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  build(context) {
    return Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(24.150, -110.32), zoom: 10),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true, // Add little blue dot for device location, requires permission from user
              mapType: MapType.normal,
              onCameraMove: _onCameraMove,
              markers: _markers,
//              trackCameraPosition: true
          ),
          Positioned(
              bottom: 50,
              right: 10,
              child:
              FlatButton(
                  child: Icon(Icons.pin_drop),
                  color: Colors.green,
                  onPressed: () => _animateToUser(),
              )
          ),
          Positioned(
            bottom:20,
            right:5,
            child:
              FlatButton(
                  child: Icon(Icons.pin_drop),
                  color: Colors.purple,
                  onPressed: () => _onAddMarkerButtonPressed(),
                  )
          )
        ]
    );
  }

  _animateToUser() async {
    var pos = await location.getLocation();
    print(pos.longitude);
    print('\n');
    print(pos.latitude);
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(pos.latitude, pos.longitude),
          zoom: 17.0,
        )
    )
    );
    _addGeoPoint();
  }

  Future<void> _addGeoPoint() async {
    var pos = await location.getLocation();
    GeoFirePoint point = geo.point(latitude: pos.latitude, longitude: pos.longitude);
    return firestore.collection('locations').document(globals.get_userID()).setData({
      'position': point.data,
      'name': 'Yay I can be queried!'
    });
  }

  void _onAddMarkerButtonPressed() {
    _markers.clear();
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: _lastMapPosition.longitude.toString(),
          snippet: _lastMapPosition.latitude.toString(),
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    print("this is the pin longitude: ");
    print(_lastMapPosition.longitude);
  }


  void checkDistance(double lat, double longit) async {
    CollectionReference f = Firestore.instance.collection("locations");
    Stream<QuerySnapshot> docs;// =  f.snapshots();
    docs = f.where("latitude", isLessThanOrEqualTo: _lastMapPosition.latitude-1).snapshots();

  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
