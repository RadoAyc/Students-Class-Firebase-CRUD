import 'package:firestore_14_12_2019/models/student.dart';
import 'package:firestore_14_12_2019/models/user.dart';
import 'package:firestore_14_12_2019/screens/home/add_form.dart';
import 'package:firestore_14_12_2019/services/auth.dart';
import 'package:firestore_14_12_2019/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firestore_14_12_2019/screens/home/student_list.dart';



    //   ********  4  **********
// NOTE  here is the home page

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showAddPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: AddForm(),
          );
      });
    }
    final user = Provider.of<User>(context);
    return StreamProvider<List<Student>>.value(
      value:  DatabaseService(uid: user.uid).students,
        child: Scaffold(
            backgroundColor: Colors.blue[50],
            appBar: AppBar(
              
              title: Text("Home"),
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Logout"),
                  onPressed: () async{
                    await _auth.signOut();
                  },
                ), 

                FlatButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Add'),
                  onPressed: ()=> _showAddPanel(),
                ),
                
              ],
            ),
            body: StudentList(),
        )
      
    );
  }
}