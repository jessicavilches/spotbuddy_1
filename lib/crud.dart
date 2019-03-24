import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;


class crudMethods {

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<void> addData(userData) async {
      Firestore.instance.collection("Users").document(globals.get_userID()).setData(userData);
    /*(userData).catchError((e) {
        print(e);
      });*/
    }



  Future<void> getName(String uId) async {
    DocumentSnapshot document = await Firestore.instance.collection("Users").document(uId).get();
    globals.eName = document.data['fullName'];
  }

  Future<void> getCity(String uId) async {
    DocumentSnapshot document = await Firestore.instance.collection("Users").document(uId).get();
    globals.eCity = document.data['city'];
  }

  Future<void> getInterest1(String uId) async {
    DocumentSnapshot document = await Firestore.instance.collection("Users").document(uId).get();
    globals.eInterest1 = document.data['interest1'];
  }

  Future<void> getInterest2(String uId) async {
    DocumentSnapshot document = await Firestore.instance.collection("Users").document(uId).get();
    globals.eInterest2 = document.data['interest2'];
  }

  Future<void> getInterest3(String uId) async {
    DocumentSnapshot document = await Firestore.instance.collection("Users").document(uId).get();
    globals.eInterest3 = document.data['interest3'];
  }

  Future<void> getInterest4(String uId) async {
    DocumentSnapshot document = await Firestore.instance.collection("Users").document(uId).get();
    globals.eInterest4 = document.data['interest4'];
  }

  Future<void> getInterest5(String uId) async {
    DocumentSnapshot document = await Firestore.instance.collection("Users").document(uId).get();
    globals.eInterest5 = document.data['interest5'];
  }

  Future<void> getUserID(String uId) async {
    DocumentSnapshot document = await Firestore.instance.collection("Users").document(uId).get();
    var doc = document.data['uid'];
    print(doc);
  }

  void getAge(String uId) async {
    DocumentSnapshot document = await Firestore.instance.collection("Users").document(uId).get();
    globals.eAge =  await document.data['age'];
  }
}


