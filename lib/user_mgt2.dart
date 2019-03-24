import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'find_buddy.dart';
import 'crud.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(new UserMgt());

class UserMgt extends StatefulWidget {

  State<StatefulWidget> createState() => new _UserMgt();
//@override
//_MyHomePageState createState() => new _MyHomePageState();
}

enum FormType {
  edit,
  save
}

class _UserMgt extends State<UserMgt>  {
  final formKey = new GlobalKey<FormState>();
  String _fullName;
  String _age;
  String _interest1;
  String _interest2;
  String _interest3;
  String _interest4;
  String _interest5;
  String _city;

  FormType _formType = FormType.edit;
  crudMethods crudObj = new crudMethods();

  void getInterest1() async {
    await crudObj.getInterest1(globals.get_userID());
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      //color: globals.tab_color,
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new ListView(
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }


  List <Widget> buildSubmitButtons() {
    return [
      new RaisedButton(
        child: new Text('Save', style: new TextStyle(fontSize: 20.0)),
         onPressed: validateAndSubmit,
      ),
    ];
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
      if (validateAndSave()) {
        addToDatabase();
      }
  }

List<Widget> buildInputs() {
    final _myPassController = TextEditingController();
    //this._mode = globals.currentItemSelected;
    return [
      new TextFormField(
          initialValue: globals.eName,
        decoration: new InputDecoration(labelText: 'Full Name'),
        validator: (value) => value.isEmpty ? 'First name can\'t be empty' : null,
        onSaved: (value) => _fullName = value,
      ),
      new TextFormField(
        initialValue: globals.eAge,
        decoration: new InputDecoration(labelText: 'Age'),
        validator: (value) => value.isEmpty ? 'Age can\'t be empty' : null,
        onSaved: (value) => _age = value,
      ),
      new TextFormField(
        initialValue: globals.eCity,
        decoration: new InputDecoration(labelText: 'City'),
        validator: (value) => value.isEmpty ? 'City can\'t be empty' : null,
        onSaved: (value) => _city = value,
      ),
      new TextFormField(
        initialValue: globals.eInterest1,
        decoration: new InputDecoration(labelText: 'Interest 1'),
        validator: (value) => value.isEmpty ? 'Interest can\'t be empty' : null,
        onSaved: (value) => _interest1 = value,
      ),
      new TextFormField(
        initialValue: globals.eInterest2,
        decoration: new InputDecoration(labelText: 'Interest 2'),
        validator: (value) => value.isEmpty ? 'Interest can\'t be empty' : null,
        onSaved: (value) => _interest2 = value,
      ),
      new TextFormField(
        initialValue: globals.eInterest3,
        decoration: new InputDecoration(labelText: 'Interest 3'),
        validator: (value) => value.isEmpty ? 'Interest can\'t be empty' : null,
        onSaved: (value) => _interest3 = value,
      ),
      new TextFormField(
        initialValue: globals.eInterest4,
        decoration: new InputDecoration(labelText: 'Interest 4'),
        validator: (value) => value.isEmpty ? 'Interest can\'t be empty' : null,
        onSaved: (value) => _interest4 = value,
      ),
      new TextFormField(
        initialValue: globals.eInterest5,
        decoration: new InputDecoration(labelText: 'Interest 5'),
        validator: (value) => value.isEmpty ? 'Interest can\'t be empty' : null,
        onSaved: (value) => _interest5 = value,
      ),
    ];
  }

  void addToDatabase() async {
    print(this._interest2);
    if(globals.loggedSuccessfully == true) {
      Map <String, dynamic> userData = {
        'fullName': this._fullName,
        'city': this._city,
        'age': this._age,
        'interest1': this._interest1,
        'interest2': this._interest2,
        'interest3': this._interest3,
        'interest4': this._interest4,
        'interest5': this._interest5,
        'uid' : globals.get_userID()
      };
      print("updated successfully");
      crudObj.addData(userData).catchError((e) {
        print(e);
      });
    }
  }

}


