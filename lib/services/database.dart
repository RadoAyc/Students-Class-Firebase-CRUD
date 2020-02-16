import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_14_12_2019/models/student.dart';
import 'package:firestore_14_12_2019/models/user.dart';

class DatabaseService{

  final String uid;
 // final User cuid;

  DatabaseService({this.uid});




  // collection reference
  final CollectionReference studentCollection = Firestore.instance.collection('students');
  final CollectionReference marksCollection = Firestore.instance.collection('students');

   
  Future addStudentData(String creatorId, String cin, String name, String birthDate, String image)async{
    return await studentCollection.document().setData({
      'creatorid' : creatorId,
      'cin': cin,
      'name': name,
      'birthdate': birthDate,
      'image' : image,
    });
  }

   Future updateStudentData(String docId, String creatorId, String cin, String name, String birthDate, String image)async{
    return await studentCollection.document(docId).setData ({
      'creatorid' : creatorId,
      'cin': cin,
      'name': name,
      'birthdate': birthDate,
      'image': image,
    });
  }

     Future deleteStudentData(String docId)async{
    return await studentCollection.document(docId).delete ();
  }


  Future updateMarksData(String docId, String subject, String firstnote, String secondnote)async{
    return await marksCollection.document(docId).collection('marks').document(subject).setData({
      'firstnote' : firstnote,
      'secondnote': secondnote,
    });
  }





  //
  List<Student> _studentListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Student(
        docId : doc.documentID,
        creatorId : doc.data['creatorid'] ?? '',
        cin : doc.data['cin'] ?? '',
        name : doc.data['name'] ?? '',
        birthDate : doc.data['birthdate'] ?? '',
        image: doc.data['image'] ?? '',
      );
    }).toList();
  }


  // userData from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){

    return UserData(
      uid: uid,
      creatorId: snapshot.data['creatorid'],
      cin: snapshot.data['cin'],
      name: snapshot.data['name'],
      birthDate: snapshot.data['birthdate'],
      image: snapshot.data['image']
    );
  }
 


  //get Students stream
  Stream<List<Student>> get students {     
    return studentCollection
    .where('creatorid', isEqualTo:uid)
    .snapshots()
    .map(_studentListFromSnapshot);
  }

   // get user doc stream
  Stream<UserData> get userData{
     return studentCollection.document(uid).snapshots()
          .map(_userDataFromSnapshot);
  }


}