import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firestore_14_12_2019/models/student.dart';
import 'package:firestore_14_12_2019/screens/home/student_tile.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {


  @override
  Widget build(BuildContext context) {
   // final user = Provider.of<User>(context);
    final students = Provider.of<List<Student>>(context) ?? [];
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index){
        return StudentTile( student: students[index]);
      },
    );
  }
}



