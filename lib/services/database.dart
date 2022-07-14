import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String userId;
  DatabaseService({required this.userId});

  //collection reference
  final CollectionReference moduleCollection = FirebaseFirestore.instance.collection('module');
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');

  Future updateUserData(String username, String password, List<int> modules) async {
    return await userCollection.doc(this.userId).set({
      'username' : username,
      'password' : password,
      'modules' : modules
    });
  }
}