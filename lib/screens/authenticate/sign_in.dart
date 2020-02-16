import 'package:firestore_14_12_2019/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firestore_14_12_2019/shared/constatnts.dart';


//NOTE  this is sign in page

class SignIn extends StatefulWidget {
  
  // this function is used to change the page from sign in to register
  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

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
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text("Sign in"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
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
                  'SignIn',
                  style: TextStyle(color: Colors.white), ),
                  onPressed: () async {
                     if (_formKey.currentState.validate()) {
                       setState(() => loading = true);
                       dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Could not Sign in with those credentials';
                            loading = false;
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
