import 'package:flutter/material.dart';
import 'package:firestore_14_12_2019/services/auth.dart';
import 'package:firestore_14_12_2019/shared/constatnts.dart';
import 'package:firestore_14_12_2019/shared/loading.dart';

//NOTE This is Register page

class Register extends StatefulWidget {

  // this function is used to change the page from register to sign in
  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
 
   // this importation of class in auth.dart to acces to auth functions

   final AuthService _auth = AuthService();

  // this key is used to validate our form 
   final _formKey = GlobalKey<FormState>();

   bool loading = false;

  // text field State

  String email = '';
  String password = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text("Sign up to get Coffee"),
        actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person),
          label: Text('SignIn'),
          onPressed: (){
            widget.toggleView();
          },
        )
      ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration,
                validator: (val) =>  val.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(()=> email = val);
                },
              ), 
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) =>  val.length < 6 ? 'Enter a password 6+ chars length' : null,
                obscureText: true,
                onChanged: (val){
                  setState(()=> password = val);
                },
              ),
               SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.brown[300],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white), ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                       setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'Please enter a valid email';
                        });
                      } 
                    }
                  },
              ),
              SizedBox(height: 20.0,),
              Text(
                error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
              )

            ],
          ),
        )
      ),
    );
  }
}