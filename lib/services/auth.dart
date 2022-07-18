import 'package:firebase_auth/firebase_auth.dart';
import 'package:pi_pcas/models/app_user.dart';
import 'package:pi_pcas/services/database.dart';
import 'package:pi_pcas/helpers/globals.dart' as globals;

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;


  AppUser? _getCurrentUser(User? user){
    return user != null ? globals.currentUser : null;
  }

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


  //auth change user stream
  Stream<AppUser?> get user {
      return _auth.authStateChanges().map((_getCurrentUser));
  }

  //sign out
  Future signOut() async {
    globals.currentUser = null;
    try {
      var sign = await _auth.signOut();
      return sign;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}