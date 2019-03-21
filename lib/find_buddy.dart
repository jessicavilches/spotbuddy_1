import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'globals.dart' as globals;


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(FindBuddy());

class FindBuddy extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<FindBuddy> with SingleTickerProviderStateMixin {
  TabController tabController;// = new TabController(length: 5, vsync: this);

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 5, vsync: this);
  }
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Find a Buddy'),
          backgroundColor: globals.tab_color,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
          bottomNavigationBar: new Material(
              color: globals.tab_color,
              child: TabBar(
                  controller: tabController,
                  tabs: <Widget>[
                    new Tab(icon: Icon(Icons.account_box)), //see your profile
                    new Tab(icon: Icon(Icons.chat)),
                    new Tab(icon: Icon(Icons.group)), //be a buddy
                    new Tab(icon: Icon(Icons.accessibility_new)), //find a buddy
                    new Tab(icon: Icon(Icons.directions_car)) //see past trips
                  ]


              )

          )
      ),
    );
  }
}

/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

//For more info...
//https://github.com/flutter/plugins/tree/master/packages/google_maps_flutter/example/lib

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Google Maps demo')),
      body: MapsDemo(),
    ),
  ));
}

class MapsDemo extends StatefulWidget {
  @override
  State createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {
  GoogleMapController mapController;
  static final LatLng center = const LatLng(32.7266, 74.8570);
  @override
  Widget build(BuildContext context) {
    return Stack(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        // LinearProgressIndicator(),
        // CircularProgressIndicator(),
        // RefreshProgressIndicator(),

        // SpinKitThreeBounce(
        //   size: 50.0,
        //   color: Colors.black,
        // ),
        GoogleMap(
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
          options: GoogleMapOptions(
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            rotateGesturesEnabled: true,
            myLocationEnabled: true,
            compassEnabled: true,
            mapType: MapType.normal,
            trackCameraPosition: true,
            zoomGesturesEnabled: true,
            cameraPosition: const CameraPosition(
              target: LatLng(-33.852, 151.211),
              zoom: 11.0,
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: _onAddMarkerButtonPressed,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          backgroundColor: Colors.green,
          child: const Icon(Icons.add_location, size: 36.0),
        ),
        Positioned(
          // left: 16.0,
          top: 70.0,
          child: FloatingActionButton(
            mini: true,
            onPressed: () {
              mapController.updateMapOptions(
                  GoogleMapOptions(mapType: MapType.satellite));
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            backgroundColor: Colors.white10,
            child: const Icon(Icons.edit_location, size: 36.0),
          ),
        ),
        Positioned(
          // left: 16.0,
          top: 130.0,
          child: FloatingActionButton(
            mini: true,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      locationDialog(mapController.cameraPosition));
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            backgroundColor: Colors.white10,
            child: const Icon(Icons.my_location, size: 36.0),
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          child: RaisedButton(
            child: Text('Move Camera'),
            color: Colors.lightGreen,
            onPressed: () {
              mapController.animateCamera(
                // CameraUpdate.newLatLng(LatLng(32.7266, 74.8570)),
                  CameraUpdate.newCameraPosition(CameraPosition(
                      target: LatLng(32.7266, 74.8570),
                      // bearing: 90.0
                      zoom: 15.0,
                      tilt: 30.0)));
            },
          ),
        ),
        // Positioned(
        //   bottom: 16.0,
        //   right: 26.0,
        //   child: RaisedButton(
        //     child: Text('Mark Pos'),
        //     color: Colors.lightGreen,
        //     onPressed: () {
        //       mapController.addMarker(
        //         MarkerOptions(
        //             position: LatLng(
        //               center.latitude,
        //               center.longitude,
        //             ),
        //             icon: BitmapDescriptor.defaultMarkerWithHue(
        //               BitmapDescriptor.hueGreen,
        //             ),
        //             // icon: BitmapDescriptor.defaultMarker,
        //             zIndex: 15.0,
        //             // rotation: 300.0, rotates the marker
        //             infoWindowText: InfoWindowText('My Location', '*'),
        //             infoWindowAnchor: Offset(1.0, 0.0),
        //             alpha: 0.5),
        //       );
        //     },
        //   ),
        // )
      ],
    );
  }

  void _onAddMarkerButtonPressed() {
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(
          mapController.cameraPosition.target.latitude,
          mapController.cameraPosition.target.longitude,
        ),
        infoWindowText: InfoWindowText('My Location', 'Home'),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  Widget locationDialog(CameraPosition pos) {
    return CupertinoAlertDialog(
      title: new Text("Current Location"),
      content: Column(
        children: [
          Text('latitude : ' + pos.target.latitude.toInt().toString()),
          Text('longitude : ' + pos.target.longitude.toInt().toString())
        ],
      ),
      actions: <Widget>[
        new CupertinoDialogAction(
            child: const Text('Discard'),
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, 'Discard');
            }),
        new CupertinoDialogAction(
            child: const Text('Cancel'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            }),
      ],
    );
  }
}
*/