import 'package:extended_image/extended_image.dart';
import 'package:firestore_14_12_2019/screens/home/add_marks_form.dart';
import 'package:firestore_14_12_2019/screens/home/edit_form.dart';
import 'package:flutter/material.dart';
import 'package:firestore_14_12_2019/models/student.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firestore_14_12_2019/services/database.dart';
class StudentTile extends StatelessWidget {

  final Student student;

    StudentTile({this.student});


  @override
  Widget build(BuildContext context) {

    void _showAddPanel(String docId){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: EditForm(doc : docId),
          );
      });
    }

    void _showAddMarksPanel(String docId){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: AddMarksForm(doc : docId),
          );
      });
    }

    void _showDialog(String docId){
       showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete"),
          content: new Text("Do you really want to delete ${student.name}"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             new FlatButton(
              child: new Text("Delete"),
              onPressed: () {
                DatabaseService().deleteStudentData(docId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    }

          //print(student.image);


    return  Slidable(
      key: ValueKey(student.docId),
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Edite',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: ()=> _showAddPanel(student.docId),
        ),
        
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: ()=> _showDialog(student.docId),
        ),
      ],
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
      ),
      
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: 
          (student.image == null)
          ?Image.asset('assets/profile.png').image
          :NetworkImage(student.image ),
          // backgroundImage: ExtendedNetworkImageProvider(
          // student.image,
          // cancelToken: true,
          // ),

          radius: 25.0,
          backgroundColor: Colors.white24,
          // backgroundImage: AssetImage('assets/coffee_icon.png'),
        ) ,
        
        title: Text(student.name),
        subtitle: Text('CIN : ${student.cin}'),
        onTap: ()=> _showAddMarksPanel(student.docId),
      ),
    );
      
    
  }
}