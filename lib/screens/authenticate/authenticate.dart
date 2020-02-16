import 'package:firestore_14_12_2019/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firestore_14_12_2019/screens/authenticate/register.dart';


    //   ********  3  **********
//NOTE  here we use Togle functions to make change between pages


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(()=> showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView : toggleView);
    }else{
      return Register(toggleView : toggleView);
    }

    
  }
}