import 'package:firestore_14_12_2019/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wrapper.dart';
import 'package:firestore_14_12_2019/models/user.dart';


           // ********* 1 *********
      // First of all im redirecting my main methode to the Wrapper File


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
          value: AuthService().user,
          child: MaterialApp(
            home: Wrapper(),
      ),
    );
  }
}
