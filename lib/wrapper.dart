import 'package:firestore_14_12_2019/screens/authenticate/authenticate.dart';
import 'package:firestore_14_12_2019/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firestore_14_12_2019/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ********* 2 *********
    // NOTE  In Wrapper we gonna to return authenticate if user isn't authenticated to app
    // And we will return Home page if he authenticate in app
    final user = Provider.of<User>(context);
    // return either HOME or Authenticate Widget
    if (user == null) {
    return Authenticate();
    } else {
    return Home();
    }
  }
}