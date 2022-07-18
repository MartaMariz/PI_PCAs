import 'package:firebase_auth/firebase_auth.dart';
import 'package:pi_pcas/models/app_user.dart';
import 'package:pi_pcas/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj from firebase user
  AppUser? _userFromFirebase(User? user){
    return user != null ? AppUser(id: user.uid, username: "hello", password: "hello", code: "123") : null;
  }

  AppUser _userFromLogIn(String id){
    return AppUser(id: id, username: "hello", password: "hello", code: "123");
  }

  //sign in anon (register - create id)
  Future signInAnon(String code, String username, String password) async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      //create user in database
      if (user != null) await DatabaseService().updateUserData(user.uid, username, password, code);
      return _userFromFirebase(user);

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<AppUser?> logIn(String username, String password) async{
    var userDoc = await DatabaseService().checkLogIn(username, password);
    if (userDoc == null) {
      print("merdou mais em cima");
      return null;
    }
    else print(userDoc.docs.first.data() as dynamic);
    var userInfo;
    userInfo = AppUser.fromJson(userDoc.docs.first.data() as
    Map<String, dynamic>, userDoc.docs.first.id);
    if (userInfo == null){
      print("merdou :(");
      return null;
    }
    else print(userInfo.getId());

    //só para o Provider saber que alguém está logged in
    UserCredential result = await _auth.signInAnonymously();

    return userInfo;
  }


  //auth change user stream
  Stream<AppUser?> get user {
      return _auth.authStateChanges()
      .map((_userFromFirebase));

  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}