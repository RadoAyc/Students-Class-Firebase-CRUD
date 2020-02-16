import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_14_12_2019/models/user.dart';
import 'package:firestore_14_12_2019/services/database.dart';
import 'package:firestore_14_12_2019/shared/constatnts.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';



class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {



  final _formKey = GlobalKey<FormState>();
  DateTime dateTime;
  String _date;
  // form values
  String _name;
  String _cin;
  String _imagePath;  
  String _fnote;
  String _snote;
  File _image;
  double _progress ;
  bool _isLoading = false;
  bool _pop;
  final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('${DateTime.now()}.jpg');
  StorageUploadTask task;
  getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      cropStyle: CropStyle.circle
      );
    setState(() {
      _image = croppedFile;
    });
  }

  progress(loading){
       
  if (loading) {
  return Column(
    children: <Widget>[
    LinearProgressIndicator(
      value: _progress,
      backgroundColor: Colors.blueGrey[100],
    ),
    Text(
    '${(_progress * 100).toStringAsFixed(2) } % '
    ),
    ],
  );
  } else {
    return Text('data');
  }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream:  DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        return Wrap(
          children: <Widget>[
            Form(
            key: _formKey,
            child:  Column(
                children: <Widget>[
                  Container(
                    child: Text(user.uid),
                  ),

                  Text(
                      'Enter Student Informations',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  SizedBox(height: 20.0),
                    (_image == null)
                    ? IconButton(
                      alignment: Alignment.center,
                      icon: Icon(Icons.image, size: 40.0),
                      color: Colors.blueAccent,
                      onPressed: ()=>getImage(),
                      
                      )
                    : Image.file(
                        _image,
                        height: 200,
                        width: 200,
                      ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText:'Cin'),
                    validator: (val) => val.isEmpty ? 'Please enter a Cin' : null,
                    onChanged: (val)=> setState(() => _cin = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText:'Name'),
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val)=> setState(() => _name
                      = val),
                  ),
                  SizedBox(height: 20.0),
                  progress(_isLoading),
                  RaisedButton.icon(
                    icon: Icon(Icons.date_range),
                    label: Text('Pick a date'),
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
                  // progress(_isLoading),
                  //
                  RaisedButton(
                    color: Colors.blue[400],
                    child: Text('ADD',
                    style: TextStyle(color: Colors.white),
                    ),
                    onPressed: ()async{
                      task = firebaseStorageRef.putFile(_image);
                      //bool __pop = await (await task.isComplete);
                     
                       task.events.listen((event) {
                      setState(() {
                      //  _imagePath=  event.snapshot.ref.getDownloadURL().toString();
                       // print(_imagePath);
                       _isLoading = true;
                       _progress = event.snapshot.bytesTransferred.toDouble() / event.snapshot.totalByteCount.toDouble();
                       print(_progress);

                        _pop = task.isComplete;

                      });
                      }).onError((error) {
                        print(error);
                      });
                      var dowurl = await (await task.onComplete).ref.getDownloadURL();
                       _imagePath = dowurl.toString();

                      //  print(_imagePath);
                      
                      if (_formKey.currentState.validate()) {
                        await DatabaseService().addStudentData(
                          user.uid,
                          _cin,
                          _name,
                          _date,
                          _imagePath,
                          
                        );
                      }

                     if(_pop){
                        Navigator.pop(context);
                      }else{
                        print('not');
                      }

                      
                      },
                    ),
                   
                ],
              ),
            
          ),
          ],
        );
      }
    );
  }
}