import 'package:firebase_auth/firebase_auth.dart';
import 'package:pi_pcas/models/app_user.dart';
import 'package:pi_pcas/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  AppUser? _userFromFirebase(User ? user){
    return user != null ? AppUser(id: user.uid) : null;
  }

/*
  //sign in anon (register - create id)
  Future signInAnon(String code, String username, String password) async{
    try{
      globals.currentUser = AppUser.withoutId(username, password, code);
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      //create user in database
      if (user != null) {
        await DatabaseService().updateUserData(
            user.uid, username, password, code);
        globals.currentUser?.setId(user.uid);
      }
      return _getCurrentUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
*/

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

  /*
  Future<AppUser?> logIn(String username, String password) async{
    var userDoc = await DatabaseService().checkLogIn(username, password);

    if (userDoc == null) return null;
    if (userDoc.docs.isEmpty) return null;

    var userInfo;
    userInfo = AppUser.fromJson(userDoc.docs.first.data() as
    Map<String, dynamic>, userDoc.docs.first.id);
    if (userInfo == null){
      print("problema");
      return null;
    }
    else {
      print(userInfo.getId());
    }

    //só para o Provider saber que alguém está logged in
    globals.currentUser = userInfo;
    UserCredential result = await _auth.signInAnonymously();
    User? userAnon = result.user;

    print("current:"+ globals.currentUser.toString());
    return _getCurrentUser(userAnon);
  }
   */


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