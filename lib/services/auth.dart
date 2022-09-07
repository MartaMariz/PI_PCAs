import 'package:firebase_auth/firebase_auth.dart';
import 'package:pi_pcas/models/app_user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  AppUser? _userFromFirebase(User ? user){
    return user != null ? AppUser(id: user.uid) : null;
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Object();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  //auth change user stream
  Stream<AppUser?> get user {
      return _auth.authStateChanges().map(_userFromFirebase);
  }

  //sign out
  Future signOut() async {
    try {
      var sign = await _auth.signOut();
      return sign;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}