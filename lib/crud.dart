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

  getData(String uId) {
    DocumentReference docRef = Firestore.instance.collection("Users").document(uId);
   // ApiFuture<DocumentSnapshot> future = docRef.get();



  }


}


