import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'globals.dart' as globals;
import 'user_data.dart';
import 'auth.dart';
import 'crud.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  crudMethods crudObj = new crudMethods();

  void getAge() async {
    await crudObj.getAge(globals.get_userID());
  }
  void getCity() async {
    await crudObj.getCity(globals.get_userID());
  }
  void getName() async {
    await crudObj.getName(globals.get_userID());
  }
  void getInterest1() async {
    await crudObj.getInterest1(globals.get_userID());
  }
  void getInterest2() async {
    await crudObj.getInterest2(globals.get_userID());
  }
  void getInterest3() async {
    await crudObj.getInterest3(globals.get_userID());
  }
  void getInterest4() async {
    await crudObj.getInterest4(globals.get_userID());
  }
  void getInterest5() async {
    await crudObj.getInterest5(globals.get_userID());
  }


  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          FirebaseUser user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
          print('Signed in: ${user.uid}');
          globals.loggedSuccessfully = true;
          globals.set_userID(user.uid);
          await getAge();
          await getCity();
          await getName();
          await getInterest1();
          await getInterest2();
          await getInterest3();
          await getInterest4();
          await getInterest5();
          print("At log in, the age is: ");
          print(globals.eAge);
          //Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed('/homepage');
        } else {
          print('did i get here');
         // FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password).then((signedInUser) {
          //  UserData().storeNewUser(signedInUser, context);
          //});
          FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
          globals.registeredSuccessfully = true;
          globals.set_userID(user.uid);
          print('Registered user: ${user.uid}');
          Navigator.of(context).pushReplacementNamed('/homepage');

        }
      }
      catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpotBuddy'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
    new TextFormField(
    decoration: new InputDecoration(labelText: 'Password'),
    obscureText: true,
    validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
    onSaved: (value) => _password = value,
    )
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text(
              'Create an account', style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return  [
        new RaisedButton(
          child: new Text('Create an account',style: new TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text('Have an account? Log In', style: new TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}