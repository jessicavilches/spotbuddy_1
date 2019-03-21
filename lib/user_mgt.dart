import 'package:flutter/material.dart';
import 'globals.dart' as globals;

void main() => runApp(new MyHomePage());

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}
*/
class MyHomePage extends StatefulWidget {
  State<StatefulWidget> createState() => new _MyHomePageState();
  //@override
  //_MyHomePageState createState() => new _MyHomePageState();
}

enum FormType {
  edit,
  save
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController tabController;
  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.save;

  void moveToEdit() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.edit;
    });
  }

  void moveToSave() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.save;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 5, vsync: this);
  }

  //@override
  Widget build(BuildContext context) {
    if (_formType == FormType.save) {
      return new Scaffold(
          body: new Stack(
            children: <Widget>[
              ClipPath(
                child: Container(color: globals.background_blue),
                clipper: globals.getClipper(),
              ),
              Positioned(
                  width: globals.screen_width,
                  top: MediaQuery.of(context).size.height / globals.profile_scale,
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                              color: globals.theme_color,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.all(Radius.circular(55.0)),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0, color: Colors.black)
                              ])),
                      SizedBox(height: 20.0),
                      /*Text(
                        'Tom Cruise',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),*/


                      new TextFormField(
                        decoration: new InputDecoration(labelText: 'First Name'),
                        validator: (value) => value.isEmpty ? 'First name can\'t be empty' : null,
                        //onSaved: (value) => _fname = value,
                      ),


                      SizedBox(height: 10.0),
                      Text(
                        'This is what other buddies will see',
                        style: TextStyle(
                            fontSize: 17.0,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Age',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 0.0),
                Container(margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(3.0),
                decoration: new BoxDecoration(
                    border: new Border.all(color: globals.box_border)
                ),
                child: new TextFormField(
                  decoration: new InputDecoration(labelText: 'Enter your Age'),
                  validator: (value) => value.isEmpty ? 'First name can\'t be empty' : null,
                  //onSaved: (value) => _fname = value,
                ),
              ),
                      SizedBox(height: 0.0),
                      Text(
                        'City',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 0.0),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: new BoxDecoration(
                            border: new Border.all(color: globals.box_border)
                        ),
                        child: new Text("Enter City"),
                      ),
                      SizedBox(height: 0.0),
                      Text(
                        'Interests',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: new BoxDecoration(
                            border: new Border.all(color: globals.box_border)
                        ),
                        child: new Text("Interest 1"),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: new BoxDecoration(
                            border: new Border.all(color: globals.box_border)
                        ),
                        child: new Text("Interest 2"),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: new BoxDecoration(
                            border: new Border.all(color: globals.box_border)
                        ),
                        child: new Text("Interest 3"),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: new BoxDecoration(
                            border: new Border.all(color: globals.box_border)
                        ),
                        child: new Text("Interest 4"),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: new BoxDecoration(
                            border: new Border.all(color: globals.box_border)
                        ),
                        child: new Text("Interest 5"),
                      ),
                      SizedBox(height: 25.0),
                      Container(
                          height: 30.0,
                          width: 95.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: globals.box_border,
                            color: Colors.blue,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: moveToEdit,
                              child: Center(
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ))
            ],
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

        ),
        /*body: new TabBarView(
          controller: tabController,
          children: <Widget> [
            MyHomePage(),
            //In here you link your icons to the .dart pages

          ]
        )*/
      );
    }
    else {
      return new Scaffold(
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: globals.background_blue),
              clipper: globals.getClipper(),
            ),
            Positioned(
                width: globals.screen_width,
                top: MediaQuery.of(context).size.height / globals.profile_scale,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            color: globals.theme_color,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(55.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),
                    SizedBox(height: 20.0),
                    Text(
                      'Tom Cruise',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'This is what other buddies will see',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Age',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 0.0),
                    Container(margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: new BoxDecoration(
                          border: new Border.all(color: globals.box_border)
                      ),
                      child: new TextFormField(decoration: new InputDecoration(labelText: 'Enter Age'),),
                    ),
                    SizedBox(height: 0.0),
                    Text(
                      'City',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 0.0),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: new BoxDecoration(
                          border: new Border.all(color: globals.box_border)
                      ),
                      child: new Text("Enter City"),
                    ),
                    SizedBox(height: 0.0),
                    Text(
                      'Interests',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: new BoxDecoration(
                          border: new Border.all(color: globals.box_border)
                      ),
                      child: new Text("Interest 1"),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: new BoxDecoration(
                          border: new Border.all(color: globals.box_border)
                      ),
                      child: new Text("Interest 2"),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: new BoxDecoration(
                          border: new Border.all(color: globals.box_border)
                      ),
                      child: new Text("Interest 3"),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: new BoxDecoration(
                          border: new Border.all(color: globals.box_border)
                      ),
                      child: new Text("Interest 4"),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: new BoxDecoration(
                          border: new Border.all(color: globals.box_border)
                      ),
                      child: new Text("Interest 5"),
                    ),
                    SizedBox(height: 25.0),
                    Container(
                        height: 30.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: globals.box_border,
                          color: Colors.blue,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: moveToEdit,
                            child: Center(
                              child: Text(
                                'Save Profile',
                                style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ))
                  ],
                ))
          ],
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

        ),
        /*body: new TabBarView(
          controller: tabController,
          children: <Widget> [
            MyHomePage(),
            //In here you link your icons to the .dart pages

          ]
        )*/
      );

    }

  }

}

