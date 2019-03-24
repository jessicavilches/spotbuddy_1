
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'globals.dart' as globals;
import 'package:location/location.dart';


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(FindBuddy());

class FindBuddy extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<FindBuddy>  {
  Completer<GoogleMapController> _controller = Completer();

  GoogleMapController mapController;
  Location location = new Location();

  _animateToUser() async {
    var pos = await location.getLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(pos.latitude, pos.longitude),
          zoom: 17.0,
        )
    )
    );
  }

  //var location = new Location();

  LocationData userLocation;


  void initState() {
    super.initState();
    _getLocation();
    setState(() {
      Future userLocation = _getLocation();
    });
  }

  //static const LatLng _center = const LatLng(45.521563, -122.677433);
  //static const LatLng _center = const LatLng(25.722248, -80.276973);
  //static const LatLng _center = const LatLng(userLocation.latitude, userLocation.longitude);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Find a Buddy'),
          backgroundColor: globals.theme_color,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            //target: _center,
            target: LatLng(25.722248, -80.276973),
            zoom: 17.0,
          ),
          myLocationEnabled: true,
        ),
      ),
    );
  }

  Future<LocationData> _getLocation() async {
    LocationData currentLocation;
    try {
      currentLocation = await location.getLocation();
      print(userLocation.latitude);
      print(userLocation.longitude);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }


}

/*
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(FindBuddy());

class FindBuddy extends StatelessWidget {
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
  GoogleMapController mapController;
  Location location = new Location();

  _animateToUser() async {
    var pos = await location.getLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(pos['latitude'], pos['longitude']),
          zoom: 17.0,
        )
    )
    );
  }


  build(context) {
    return Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(24.150, -110.32), zoom: 10),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true, // Add little blue dot for device location, requires permission from user
              mapType: MapType.hybrid,
              trackCameraPosition: true
          ),
    Positioned(
    bottom: 50,
    right: 10,
    child:
    FlatButton(
    child: Icon(Icons.pin_drop),
    color: Colors.green,
    onPressed: () => _addMarker()
    ))
           ]
    );
  }

  _addMarker() {
    var marker = MarkerOptions(
        position: mapController.cameraPosition.target,
        icon: BitmapDescriptor.defaultMarker,
        infoWindowText: InfoWindowText('Magic Marker', '🍄🍄🍄')
    );

    mapController.addMarker(marker);
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
*/
