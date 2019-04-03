import 'package:flutter/material.dart';
import 'crud.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

var theme_color = Colors.blue;
var tab_color = Colors.blueGrey;
var profile_scale = 10;
var screen_width = 400.0;
var background_blue = Colors.lightBlue.withOpacity(0.2);
var box_border = Colors.blueAccent;

var UserModes = ['Be a Buddy', 'Not be a buddy'];
var currentItemSelected = UserModes[0];

String eAge = "";
String eName = "";
String eCity = "";
String eInterest1 = "";
String eInterest2 = "";
String eInterest3 = "";
String eInterest4 = "";
String eInterest5 = "";

bool registeredSuccessfully;
bool loggedSuccessfully;
String _userID = "";

crudMethods crudObj = new crudMethods();

void getAge() async {
  await crudObj.getAge(get_userID());
}
void getCity() async {
  await crudObj.getCity(get_userID());
}
void getName() async {
  await crudObj.getName(get_userID());
}
void getInterest1() async {
  await crudObj.getInterest1(get_userID());
}
void getInterest2() async {
  await crudObj.getInterest2(get_userID());
}
void getInterest3() async {
  await crudObj.getInterest3(get_userID());
}
void getInterest4() async {
  await crudObj.getInterest4(get_userID());
}
void getInterest5() async {
  await crudObj.getInterest5(get_userID());
}



void set_userID(String uid) {
  _userID = uid;
}

String get_userID()
{
  return _userID;
}

final FirebaseAnalytics analytics = new FirebaseAnalytics();

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

