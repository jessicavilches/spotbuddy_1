import 'package:flutter/material.dart';
import 'auth.dart';
import 'user_mgt2.dart';
import 'login_page.dart';
import 'feed.dart';
import 'map.dart';
import 'crud.dart';
import 'package:firebase_analytics/observer.dart';
import 'globals.dart' as globals;

final FirebaseAnalyticsObserver observer = new FirebaseAnalyticsObserver(analytics: globals.analytics);

class HomePage extends StatefulWidget{
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int currentTab = 0;
  //FindBuddy findBuddy;
  UserMgt usermgt;
  LoginPage login;
  Map map;
  Feed feed;


  List<Widget> pages;
  Widget currentPage;


  @override
  void initState(){
    //findBuddy = FindBuddy();
    usermgt = UserMgt();
    login = LoginPage();
    feed = Feed();

    map = Map();
    currentPage = map;
    currentTab = 1;
   // pages = [usermgt, findBuddy];
    pages = [usermgt, feed, map];

    super.initState();
  }

  void moveToFindBuddy()
  {
    setState(() {
      //currentPage = findBuddy;
      currentPage = map;
      currentTab = 1;
      sendCurrentTabToAnalytics("map");
    });

  }
  void moveToUserMgt() async
  {
    await globals.getInterest1();
    await globals.getInterest2();
    await globals.getInterest5();
    await globals.getInterest3();
    await globals.getInterest4();
    await globals.getAge();
    await globals.getCity();
    await globals.getName();
    await globals.getEmail();
    setState(() {
      currentPage = usermgt;
      currentTab = 0;
      sendCurrentTabToAnalytics("usermgt");
    });

  }

  void moveToLogin() {
    setState(() {
      currentPage = login;
      //currentTab = 0;
      sendCurrentTabToAnalytics("login");
    });
  }

  void moveToFeed() {
    setState(() {
      currentPage = feed;
      currentTab = 2;
      sendCurrentTabToAnalytics("feed");
    });
  }

  void _signOut() async
  {
    //moveToLogin();
   //Navigator.of(context).pop();
   Navigator.of(context).pushReplacementNamed('/login');
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: new AppBar(
          title: new Text('SpotBuddy', style: new TextStyle(fontSize: 20.0)),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Logout', style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: _signOut,
            )
          ]
      ),
      body: currentPage,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (int index){
          setState(() {
            //print(index);
            currentTab = index;
            currentPage = usermgt;
            sendCurrentTabToAnalytics("usermgt");
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new IconButton(
              icon: new Icon(Icons.account_box),
              iconSize: 40,
              onPressed: moveToUserMgt,
            ),
            title: Text('Profile'),
          ),

          BottomNavigationBarItem(
            icon: new IconButton(
              icon: new Icon(Icons.accessibility_new),
              iconSize: 40,
              onPressed: moveToFindBuddy,
            ),
            title: Text('Find Buddy'),
          ),

          BottomNavigationBarItem(
            icon: new IconButton(
                icon: new Icon(Icons.chat),
                iconSize: 40,
                onPressed: moveToFeed,
            ),
            title: Text('Feed'),
          ),


          /*BottomNavigationBarItem(
            icon: new IconButton(
                icon: new Icon(Icons.directions_car),
                iconSize: 40,
                onPressed: null
            ),
            title: Text('Ride History'),
          ),*/
        ],
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.pink,
      ),
    );
  }
}

void sendCurrentTabToAnalytics(name) {
  observer.analytics.setCurrentScreen(
    screenName: name,
  );
}