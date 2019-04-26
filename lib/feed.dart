import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'crud.dart';
import 'dart:async';
import 'email.dart';
import 'home.dart';

class Feed extends StatefulWidget{
  @override
  _Feed createState() => new _Feed();
}

class _Feed extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text('Pool Feed')
      // ),
        child: ListPage()
      //);
    );
  }
}
class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  Future _data;


  Future getPosts() async {
    print("name of element at 0");
    await print(globals.matchingUsers.elementAt(0).data["name"]);
    if (globals.matchingUsers.isNotEmpty)
    return globals.matchingUsers.cast<dynamic>();
    else
      "no data";
   // var firestore = Firestore.instance;
   // QuerySnapshot qn = await firestore.collection('Rides').getDocuments(); // move to crud
   // return qn.documents;
  }

  navigateToDetail(DocumentSnapshot ride){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(ride: ride,)));
  }

  navigateToFindBuddy() {
    HomePage hp = new HomePage();
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

  }

  @override
  initState() {

    super.initState();
    _data = getPosts();
  }



  @override
  Widget build(BuildContext context) {
    if (globals.matchingUsers.isNotEmpty){
    return Container(
      child: FutureBuilder(
          future: _data,
          builder: (_,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('\n'+ (snapshot.data[index].data["name"]) + '\n', textScaleFactor: 2,),  //Name: '
                          Text('Interest 1: ' + snapshot.data[index].data["i1"]),
                          Text('Interest 2: '+ snapshot.data[index].data["i2"]),
                          Text('Interest 3: ' + (snapshot.data[index].data["i3"])),
                          Text('Interest 4: ' + (snapshot.data[index].data["i4"])),
                          Text('Interest 5: ' + (snapshot.data[index].data["i5"])),
                          ButtonTheme.bar( // make buttons use the appropriate styles for cards
                            child: ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  child: const Text('View'),
                                  onPressed: () => navigateToDetail(snapshot.data[index]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
  else return Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text ("Use Find Buddy First", textAlign: TextAlign.center, textScaleFactor: 3),
          new RaisedButton(
            child: new Text('Take Me There', style: new TextStyle(fontSize: 20.0)),
            onPressed: () => Navigator.of(context).pushReplacementNamed('/map'),
          ),
        ],
      )
    );
  }
}


class DetailPage extends StatefulWidget {
  final DocumentSnapshot ride;
  DetailPage({this.ride});
  @override
  _DetailPageState createState() => _DetailPageState();
}
class _DetailPageState extends State<DetailPage>{
  final formKey = new GlobalKey<FormState>();
  crudMethods crudObj = new crudMethods();

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context){
    //sendEmail sendemail = new sendEmail();
    globals.matchEmail = widget.ride.data["email"];

    return Scaffold (
      appBar: AppBar(
        title: Text("Match"),//(widget.ride.data["name"])),
      ),
      body: Container(
        child: Card(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('\n'+ (widget.ride.data["name"]) + '\n', textScaleFactor: 2,), //'\nName: '+
                Text('City: ' + widget.ride.data["city"]),
                Text('Age: ' + widget.ride.data["age"]),
                Text('Interest 1: ' + widget.ride.data["i1"]),
                Text('Interest 2: '+ widget.ride.data["i2"]),
                Text('Interest 3: ' + (widget.ride.data["i3"])),
                Text('Interest 4: ' + (widget.ride.data["i4"])),
                Text('Interest 5: ' + (widget.ride.data["i5"])),
                ButtonTheme.bar( // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('Reach out!'),
                        onPressed: () => Navigator.of(context).pushReplacementNamed('/email'),
                        ///onPressed: () => addToDatabase(),
                        //this should email the person
                      ),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }



}


