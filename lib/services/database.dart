import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/meal.dart';
import '../models/user_data.dart';

class DatabaseService{

  late String id;

  //collection reference
  final CollectionReference moduleCollection = FirebaseFirestore.instance.collection('module');
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');
  final CollectionReference recordCollection = FirebaseFirestore.instance.collection('record');

  Future updateUserData(String userId, String username, int image, String code) async {
    id = userId;
    return await userCollection.doc(userId).set({
      'username' : username,
      'code' : code,
      'image' : image
    });
  }

  Future updateRecordData(String userCode, Meal meal) async {
    if (meal.skipped) {
      return await recordCollection.doc(userCode+"-"+meal.day+"-"+meal.meal).set({
        'meal' : meal.meal,
        'day' : meal.day,
        'user' : userCode,
        'skipped' : meal.skipped,
    });}
    else {
      return await recordCollection.doc(userCode+"-"+meal.day+"-"+meal.meal).set({
        'meal' : meal.meal,
        'day' : meal.day,
        'user' : userCode,
        'food' : meal.food,
        'time' : meal.time,
        'feeling' : meal.feeling,
        'share' : meal.share,
      });
    }
  }

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

  Future<UserData?> retrieveCurrentUserData(String id) async {
    var doc = await userCollection.doc(id).get();

    if (doc == null) {
      return null;
    } else {
      print(doc.data().toString());
    }

    var userInfo = UserData.fromJson(doc.data() as Map<String, dynamic>, id);
    if (userInfo == null){
      print("problema");
      return null;
    }
    else {
      return userInfo;
    }
  }

  Future<Meal?> retrieveCurrentRecordData(String userId, String day, String meal) async {
    var doc = await userCollection.doc(userId+"-"+day+"-"+meal).get();

    if (doc == null) return null;
    else print(doc.data().toString());

    var mealRetrieved = Meal.fromJson(doc.data() as Map<String, dynamic>);
    if (mealRetrieved == null){
      print("problema");
      return null;
    }
    else {
      return mealRetrieved;
    }
  }
}