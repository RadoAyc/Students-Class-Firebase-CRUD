import 'package:firestore_14_12_2019/models/user.dart';
import 'package:firestore_14_12_2019/services/database.dart';
import 'package:firestore_14_12_2019/shared/constatnts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AddMarksForm extends StatefulWidget {

    final String doc;
    AddMarksForm({this.doc});
  @override
  _AddMarksFormState createState() => _AddMarksFormState();


}

class _AddMarksFormState extends State<AddMarksForm> {

  final _formKey = GlobalKey<FormState>();

  String _fnote;
  String _snote;
  String _subject;

  final List<String> subject= ['Mathematics','English','Physics','Chemistry','biology'];
  
  

String _doc;
@override
void initState() { 
  super.initState();
  _doc=widget.doc;
}

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream:  DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        return Form(
              key: _formKey,
                      child: Column(
                children: <Widget>[
                  Container(
                    child: Text(user.uid),
                  ),

                  Text(
                      'Enter Student Informations',
                      style: TextStyle(fontSize: 18.0),
                    ),

                     //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration.copyWith(hintText:'Subjects'),
                    value: _subject ,
                    items: subject.map((subject){
                      return DropdownMenuItem(
                        value: subject,
                        child: Text('$subject'),
                      );
                    }).toList(),
                    onChanged: (val)=> setState(() => _subject = val),
                  ),


                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'First Note'),
                      validator: (val) => val.isEmpty ? 'Please enter the First Note' : null,
                      onChanged: (val)=> setState(() => _fnote = val),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'Second Note'),
                      validator: (val) => val.isEmpty ? 'Please enter the Second Note' : null,
                      onChanged: (val)=> setState(() => _snote = val),
                    ),
                    SizedBox(height: 20.0),

                    RaisedButton(
                      color: Colors.blue[400],
                      child: Text('ADD Marks',
                      style: TextStyle(color: Colors.white),
                      ),
                      onPressed: ()async{

                        if (_formKey.currentState.validate()) {
                          await DatabaseService().updateMarksData(

                            _doc,
                            _subject,
                            _fnote,
                            _snote,
                          );
                        }
                        Navigator.pop(context);
                      },
                    ),

//THIS CODE IS FOR ADDING MARKS IN SUBCOLLECTION

                  //   SizedBox(height: 20.0),
                  //   TextFormField(
                  //     validator: (val) => val.isEmpty ? 'Please enter first note' : null,
                  //     onChanged: (val)=> setState(() => _fnote = val),
                  //   ),
                  //   SizedBox(height: 20.0),
                  //   TextFormField(
                  //     validator: (val) => val.isEmpty ? 'Please enter second note' : null,
                  //     onChanged: (val)=> setState(() => _snote = val),
                  //   ),
                  //   SizedBox(height: 20.0),
                  //  //
                  //   RaisedButton(
                  //     color: Colors.blue[400],
                  //     child: Text('subcol',
                  //     style: TextStyle(color: Colors.white),
                  //     ),
                  //     onPressed: ()async{

                  //       if (_formKey.currentState.validate()) {
                  //         await DatabaseService(buid: 'pouJsGxoD3XgOwecevqH').updateMarksData(
                  //           _fnote,
                  //           _snote,
                  //         );
                  //       }
                  //     },
                  //   ),


                ],
              ),
            
        );
      }
    );
  }
}