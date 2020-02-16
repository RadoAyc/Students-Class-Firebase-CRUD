import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_14_12_2019/models/user.dart';


    //   ********  5  **********
// NOTE In this class we gonna set all authentication functions
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FIrebaseUser
  User _userFromFirebaseUser(FirebaseUser user){

    return user != null ? User(uid: user.uid) : null;
    
  }

  // auth change user stream
  Stream<User> get user {
    
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  }

  //Sign in Anonymously
  Future signInAnon() async{
    try {
    AuthResult result =  await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // Sign in with email & password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

// Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }
  //Sign Out
Future signOut() async {
  try {
  return await _auth.signOut();
  } catch (e) {
    print(e.toString());
    return null;
  }
}
}