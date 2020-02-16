import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_14_12_2019/models/user.dart';
import 'package:firestore_14_12_2019/services/database.dart';
import 'package:firestore_14_12_2019/shared/constatnts.dart';
import 'package:firestore_14_12_2019/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EditForm extends StatefulWidget {
  final String doc;
    EditForm({this.doc});
  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {

String _doc;
@override
void initState() { 
  super.initState();
  _doc=widget.doc;
}

  final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('myimage4.jpg');
  StorageUploadTask task;

  final _formKey = GlobalKey<FormState>();
  DateTime dateTime;
   String _date;
  // form values
  String _name;
  String _cin;  
  String _imagePath;



  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream:  DatabaseService(uid: _doc).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                    'Enter Student Informations',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.cin,
                    decoration: textInputDecoration.copyWith(hintText:'Cin'),
                    validator: (val) => val.isEmpty ? 'Please enter a Cin' : null,
                    onChanged: (val)=> setState(() => _cin = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(hintText:'Name'),
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val)=> setState(() => _name
                      = val),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    userData.birthDate
                  ),
                  SizedBox(height: 20.0),
                RaisedButton(
                  child: Text('Pick a date'),
                  onPressed: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2050),
                    ).then((date){
                      _date ="${date.day}/${date.month}/${date.year}" ;
                    });
                  },
                ),
                  SizedBox(height: 20.0),
                  //
                  RaisedButton(
                    color: Colors.blue[400],
                    child: Text('Update',
                    style: TextStyle(color: Colors.white),
                    ),
                    onPressed: ()async{
                      if (_formKey.currentState.validate()) {
                        await DatabaseService().updateStudentData(
                          _doc,
                          user.uid,
                          _cin ?? snapshot.data.cin,
                          _name ?? snapshot.data.name,
                          _date ?? snapshot.data.birthDate,
                          _imagePath ?? snapshot.data.image,
                        );
                      }
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
        );
        }else{
          return Loading();
        }
      }
    );
  }
}