import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'crud.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(new MyHomePage2());

class MyHomePage2 extends StatefulWidget {

  State<StatefulWidget> createState() => new _MyHomePageState2();
//@override
//_MyHomePageState createState() => new _MyHomePageState();
}

enum FormType {
  edit,
  save
}

class _MyHomePageState2 extends State<MyHomePage2> with SingleTickerProviderStateMixin {
  TabController tabController;// = new TabController(length: 5, vsync: this);

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 5, vsync: this);
  }
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
    );
  }


  List <Widget> buildSubmitButtons() {
    return [
      new RaisedButton(
        child: new Text('Save', style: new TextStyle(fontSize: 20.0)),
         onPressed: validateAndSubmit,
      )
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
      //form.save();
      //make sure to set_userID in the registration form
      if (validateAndSave()) {
       // String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
        //FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        //String userID = user.uid;
        addToDatabase();
      }
  }

List<Widget> buildInputs(){
  // else if (_formType == FormType.register){
    final _myPassController = TextEditingController();
    //this._mode = globals.currentItemSelected;
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Full Name'),
        validator: (value) => value.isEmpty ? 'First name can\'t be empty' : null,
        onSaved: (value) => _fullName = value,
      ),
      new TextFormField(
        initialValue: "Matt",
        decoration: new InputDecoration(labelText: 'Age'),
        validator: (value) => value.isEmpty ? 'Age can\'t be empty' : null,
        onSaved: (value) => _age = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'City'),
        validator: (value) => value.isEmpty ? 'City can\'t be empty' : null,
        onSaved: (value) => _city = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Interest 1'),
        validator: (value) => value.isEmpty ? 'Interest can\'t be empty' : null,
        onSaved: (value) => _interest1 = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Interest 2'),
        validator: (value) => value.isEmpty ? 'Interest can\'t be empty' : null,
        onSaved: (value) => _interest2 = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Interest 3'),
        validator: (value) => value.isEmpty ? 'Interest can\'t be empty' : null,
        onSaved: (value) => _interest3 = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Interest 4'),
        validator: (value) => value.isEmpty ? 'Interest can\'t be empty' : null,
        onSaved: (value) => _interest4 = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Interest 5'),
        validator: (value) => value.isEmpty ? 'Interest can\'t be empty' : null,
        onSaved: (value) => _interest5 = value,
      ),
    ];
  }

  void addToDatabase() async {
    if(globals.registeredSuccessfully == true) {
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
      crudObj.addData(userData).catchError((e) {
        print(e);
      });
    }
  }

}


