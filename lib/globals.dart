import 'package:flutter/material.dart';

var theme_color = Colors.blue;
var tab_color = Colors.blueGrey;
var profile_scale = 10;
var screen_width = 400.0;
var background_blue = Colors.lightBlue.withOpacity(0.2);
var box_border = Colors.blueAccent;
bool registeredSuccessfully;
bool loggedSuccessfully;

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

