import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/widgets.dart';

class UserData {


  storeNewUser(user, context) {
    Firestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
      'fullname': "Enter Name",
      'age': "Enter Age",
      'city': " Enter City",
      'interest1': "Enter interest 1",
      'interest2': "Enter interest 2",
      'interest3': "Enter interest 3",
      'interest4': "Enter interest 4",
      'interest5': "Enter interest 5",
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      print(e);
    });
  }
}