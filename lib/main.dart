import 'package:flutter/material.dart';
import 'login_page.dart';
import 'user_mgt2.dart';
//import 'package:spotbuddy_1/globals.properties';
import 'globals.dart' as globals;
import 'home.dart';
import 'package:firebase_analytics/observer.dart';

void main() => runApp(MyApp());

final FirebaseAnalyticsObserver observer = new FirebaseAnalyticsObserver(analytics: globals.analytics);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.green,
       primarySwatch: globals.theme_color,
      ),
        //home: new UserMgt(),
        //home: new HomePage(),
        //home: new FindBuddy(),
        home: new LoginPage(),
        navigatorObservers: [
          observer,
        ],
        routes: <String, WidgetBuilder> {
          '/homepage': (BuildContext context) => new HomePage(),
          '/login': (BuildContext context) => new LoginPage(),
        }
    );
  }
}