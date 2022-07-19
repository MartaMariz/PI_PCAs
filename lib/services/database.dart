import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';
import '../models/user_data.dart';

class DatabaseService{

  late String id;

  //collection reference
  final CollectionReference moduleCollection = FirebaseFirestore.instance.collection('module');
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');

  Future updateUserData(String userId, String username, int image, String code) async {
    id = userId;
    return await userCollection.doc(userId).set({
      'username' : username,
      'code' : code,
      'image' : image
    });
  }

  /*
  Future<QuerySnapshot<Object?>?> checkLogIn(String username, String password) async {
    final user = userCollection.where('username', isEqualTo: username).where('password', isEqualTo: password).snapshots();
    final empty = await user.isEmpty;
    if (empty) return null;
    else {
      final userDoc = await user.first;
      return userDoc;
    }
  }
  */

  Stream<UserData> userData(String userId) {
    id = userId;
    return userCollection.doc(id).snapshots().map(userDataFromSnapshot);
  }

  UserData userDataFromSnapshot(DocumentSnapshot snapshot){
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return UserData(
        id: id,
        username: data['username'],
        code: data['code'],
        image: data['image']
    );
  }
}