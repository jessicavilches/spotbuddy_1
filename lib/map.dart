import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'globals.dart' as globals;
import 'package:firebase_analytics/observer.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'globals.dart' as globals;

void main() => runApp(Map());

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: FireMap()
        ),
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

  LatLng _lastMapPosition = LatLng(25.7617, -80.1918);
  Location location = new Location();
  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();

  final Set<Marker> _markers = Set();
  final Set<Marker> _mark = Set();

  //final Marker one = new Marker()

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  build(context) {
    return Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(25.7617, -80.1918), zoom: 10),
            onMapCreated: _onMapCreated,
            myLocationEnabled: true, // Add little blue dot for device location, requires permission from user
            mapType: MapType.normal,
            onCameraMove: _onCameraMove,
            markers: _mark,
            //markers: _mark,
//              trackCameraPosition: true
          ),
          Positioned(
              bottom: 78,
              height: 60,
              right: 5,
              child:
              FlatButton(
                child: Column(
                  children: <Widget> [
                    Icon(Icons.pin_drop),
                    Text("Go To"),
                    Text("Your Location")
                  ],
                ),
                color: Colors.green,
                //child: Text("location"),
                onPressed: () => _animateToUser(),
              )
          ),
          Positioned(
              bottom:8,
              height:60,
              right:5,
              child:
              FlatButton(
                child: Column(
                  children: <Widget> [
                    Icon(Icons.pin_drop),
                    Text("Find"),
                    Text("    Matches    ")
                  ],
                ),
                color: Colors.purple,
                onPressed: () => _onAddMarkerButtonPressed(),
              )
          ),
         /* Positioned(
            bottom: 100,
            right: 5,
            child:
            FlatButton(
              child: Icon(Icons.pin_drop),
              color: Colors.orange,
              onPressed: () => _startQuery(),
            )
          )*/
        ]
    );
  }

  _animateToUser() async {
    await globals.getInterest1();
    await globals.getInterest2();
    await globals.getInterest5();
    await globals.getInterest3();
    await globals.getInterest4();
    await globals.getAge();
    await globals.getCity();
    await globals.getName();
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
    await _addGeoPoint();
  }

  Future<void> _addGeoPoint() async {
    var pos = await location.getLocation();
    GeoFirePoint point = geo.point(latitude: pos.latitude, longitude: pos.longitude);
    return firestore.collection('locations').document(globals.get_userID()).setData({
      'position': point.data,
      'name': globals.eName,
      'i1': globals.eInterest1,
      'i2': globals.eInterest2,
      'i3' : globals.eInterest3,
      'i4' : globals.eInterest4,
      'i5' : globals.eInterest5,
      'email' : globals.email,
      'city' : globals.eCity,
      'age' : globals.eAge,
    });
  }

  void _onAddMarkerButtonPressed() {
    globals.matchingUsers.clear();
    //_markers.clear();
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
    print("this is the pin latitude: ");
    print(_lastMapPosition.latitude);
    _startQuery();
  }


  /*void checkDistance(double lat, double longit) async {
    CollectionReference f = Firestore.instance.collection("locations");
    Stream<QuerySnapshot> docs;// =  f.snapshots();
    //docs = f.where("latitude", isLessThanOrEqualTo: _lastMapPosition.latitude+1).snapshots();
    docs = f.where("latitude", isLessThanOrEqualTo: ).snapshots();

  }*/

  String similarInterest(DocumentSnapshot document) {
    String str = "";
    if(globals.eInterest1 == document.data['i1'])
      str += document.data['i1'] + ", ";
    if(globals.eInterest1 == document.data['i2'])
      str += document.data['i2'] + ", ";
    if(globals.eInterest1 == document.data['i3'])
      str += document.data['i3'] + ", ";
    if(globals.eInterest1 == document.data['i4'])
      str += document.data['i4'] + ", ";
    if(globals.eInterest1 == document.data['i5'])
      str += document.data['i5'] + ", ";
    if(globals.eInterest2 == document.data['i1'])
      str += document.data['i1'] + ", ";
    if(globals.eInterest2 == document.data['i2'])
      str += document.data['i2'] + ", ";
    if(globals.eInterest2 == document.data['i3'])
      str += document.data['i3'] + ", ";
    if(globals.eInterest2 == document.data['i4'])
      str += document.data['i4'] + ", ";
    if(globals.eInterest2 == document.data['i5'])
      str += document.data['i5'] + ", ";
    if(globals.eInterest3 == document.data['i1'])
      str += document.data['i1'] + ", ";
    if(globals.eInterest3 == document.data['i2'])
      str += document.data['i2'] + ", ";
    if(globals.eInterest3 == document.data['i3'])
      str += document.data['i3'] + ", ";
    if(globals.eInterest3 == document.data['i4'])
      str += document.data['i4'] + ", ";
    if(globals.eInterest3 == document.data['i5'])
      str += document.data['i5'] + ", ";
    if(globals.eInterest4 == document.data['i1'])
      str += document.data['i1'] + ", ";
    if(globals.eInterest4 == document.data['i2'])
      str += document.data['i2'] + ", ";
    if(globals.eInterest4 == document.data['i3'])
      str += document.data['i3'] + ", ";
    if(globals.eInterest4 == document.data['i4'])
      str += document.data['i4'] + ", ";
    if(globals.eInterest4 == document.data['i5'])
      str += document.data['i5'] + ", ";
    if(globals.eInterest5 == document.data['i1'])
      str += document.data['i1'] + ", ";
    if(globals.eInterest5 == document.data['i2'])
      str += document.data['i2'] + ", ";
    if(globals.eInterest5 == document.data['i3'])
      str += document.data['i3'] + ", ";
    if(globals.eInterest5 == document.data['i4'])
      str += document.data['i4'] + ", ";
    if(globals.eInterest5 == document.data['i5'])
      str += document.data['i5'] + ", ";
    return str;
  }


  // Stateful Data
  BehaviorSubject<double> radius = BehaviorSubject(seedValue: 30.0);//seedValue: 100.0);
  Stream<dynamic> query;

  // Subscription
  StreamSubscription subscription;

  /*_addMarker() {
    var marker = MarkerOptions(
        position: mapController.cameraPosition.target,
        icon: BitmapDescriptor.defaultMarker,
        infoWindowText: InfoWindowText('Magic Marker', '🍄🍄🍄')
    );

    mapController.addMarker(marker);
  }*/

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    print(documentList);
    //mapController.clearMarkers();
    /*mapController.markers.forEach((marker){
      mapController.removeMarker(marker);
    });
    documentList.forEach((DocumentSnapshot document) {
      GeoPoint pos = document.data['position']['geopoint'];
      double distance = document.data['distance'];
      var marker = MarkerOptions(
          position: LatLng(pos.latitude, pos.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindowText: InfoWindowText('Magic Marker', '$distance kilometers from query center')
      );


      mapController.addMarker(marker);
    });*/
    //_mark.clear();
    setState(() {
      int i = 0; /////new line for matching users
      documentList.forEach((DocumentSnapshot document) {
        GeoPoint pos = document.data['position']['geopoint'];
        double distance = document.data['distance'];
        String interests;
        print("document ID:");
        print(document.documentID);
        print("user ID:");
        print(globals.get_userID());

        if(  ((interests = similarInterest(document)) != "") && (document.documentID != globals.get_userID()))  {
          globals.matchingUsers.insert(i, document); /////new line for matching users
          print("name of the one i just inserted:");
          print(globals.matchingUsers.elementAt(i).data["name"]);
          i++; /////new line for matching users
          _mark.add(Marker(
            //markerId: MarkerId(_lastMapPosition.toString()),
            markerId: MarkerId(
                pos.latitude.toString() + pos.longitude.toString()),
            position: LatLng(pos.latitude, pos.longitude),
            infoWindow: InfoWindow(
              title: document.data['name'], //_lastMapPosition.longitude.toString(),
              snippet: interests, //document.data['i1'], //_lastMapPosition.latitude.toString(),
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet), //BitmapDescriptor.defaultMarker,
          ));
        }
        print("this is the document id");
        print(document.documentID);
        print("This is the latitude of the db point");
        print(pos.latitude.toString());
      });
    });

  }

  _startQuery() async {
    // Get users location
    var pos = await location.getLocation();
    double lat = pos.latitude; //pos['latitude'];
    double lng = pos.longitude; //pos['longitude'];


    // Make a referece to firestore
    var ref = firestore.collection('locations');
    GeoFirePoint center = geo.point(latitude: lat, longitude: lng);

    // subscribe to query
    subscription = radius.switchMap((rad) {
      return geo.collection(collectionRef: ref).within(
          center: center,
          radius: rad,
          field: 'position',
          strictMode: true
      );
    }).listen(_updateMarkers);
  }

  _updateQuery(value) {
    setState(() {
      radius.add(value);
    });
  }





  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    _updateQuery(25.0);
  }
}