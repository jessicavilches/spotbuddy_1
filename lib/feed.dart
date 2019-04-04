import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'crud.dart';
import 'dart:async';

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
    return globals.matchingUsers.cast<dynamic>();
   // var firestore = Firestore.instance;
   // QuerySnapshot qn = await firestore.collection('Rides').getDocuments(); // move to crud
   // return qn.documents;
  }

  navigateToDetail(DocumentSnapshot ride){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(ride: ride,)));
  }

  @override
  initState() {

    super.initState();
    _data = getPosts();
  }



  @override
  Widget build(BuildContext context) {
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
                          Text('\nName: '+ (snapshot.data[index].data["name"]) + '\n'),
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
    return Scaffold (
      appBar: AppBar(
        title: Text((widget.ride.data["name"])),
      ),
      body: Container(
        child: Card(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('\nName: '+ (widget.ride.data["name"]) + '\n'),
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
                        onPressed: () => Navigator.of(context).pushReplacementNamed('/map')
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
  void addToDatabase() async {
    //if(validateAndSave()) {
    Map <String, dynamic> rideCatalog = {
      'date': widget.ride.data["date"],
      'start_time': widget.ride.data["start_time"],
      'end_time': widget.ride.data["end_time"],
      'start_address': widget.ride.data["start_address"],
      'end_address': widget.ride.data["end_address"],
      'rider_id' : globals.get_userID(),
      'driver_id' : widget.ride.data["uid"],
      'status' : "Pending",
    };
    //}
    // moveToLogin(); This should clear all values and let you submit a new ride
    //}
  }


}


