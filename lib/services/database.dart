import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/meal.dart';
import '../models/module.dart';
import '../models/submodule.dart';
import '../models/user_data.dart';

class DatabaseService{

  late String id;

  //collection reference
  final CollectionReference moduleCollection = FirebaseFirestore.instance.collection('module');
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');
  final CollectionReference recordCollection = FirebaseFirestore.instance.collection('record');

  Future updateUserData(String userId, String username, int image, String code,
      List<int> submodules) async {
    id = userId;
    return await userCollection
        .doc(userId)
        .set({
      'username' : username,
      'code' : code,
      'image' : image,
      'submodules' : submodules
    });
  }

  Future updateRecordData(String userCode, Meal meal) async {
    if (meal.skipped) {
      return await recordCollection
          .doc(userCode+"-"+meal.day+"-"+meal.meal)
          .set({
        'meal' : meal.meal,
        'day' : meal.day,
        'user' : userCode,
        'skipped' : meal.skipped,
    });}
    else {
      return await recordCollection
          .doc(userCode+"-"+meal.day+"-"+meal.meal)
          .set({
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
    return userCollection
        .doc(id)
        .snapshots()
        .map(userDataFromSnapshot);
  }

  UserData userDataFromSnapshot(DocumentSnapshot snapshot){
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return UserData(
        id: id,
        username: data['username'],
        code: data['code'],
        image: data['image'],
        submodulesUnlocked: data['submodules']
    );
  }

  Future<List<Module>> retrieveAllCurrentModules() async {
    List<Module> result = [];
    var modules = await moduleCollection.get();
    for (var moduleSnap in modules.docs){
      var mod = await retrieveCurrentModuleData(moduleSnap);
      if (mod != null) {
        result.add(mod);
      }
    }
    return result;
  }

  Stream<Module> modules() {
    return moduleCollection.get().asStream().map(modulesFromSnapshot);
  }

  Module modulesFromSnapshot(QuerySnapshot snapshot){
    Map<String, dynamic> data = snapshot.docs.first as Map<String, dynamic>;
    return Module.incomplete(
        data['name'],
        data['description']
    );
  }

  Future<UserData?> retrieveCurrentUserData(String id) async {
    var doc = await userCollection
        .doc(id)
        .get();

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

  Future<Meal?> retrieveCurrentRecordData(String userId, String day,
      String meal) async {
    var doc = await userCollection
        .doc(userId+"-"+day+"-"+meal)
        .get();

    if (doc == null) {
      return null;
    } else {
      print(doc.data().toString());
    }

    var mealRetrieved = Meal.fromJson(doc.data() as Map<String, dynamic>);
    if (mealRetrieved == null){
      print("problema");
      return null;
    }
    else {
      return mealRetrieved;
    }
  }

  Future<Module?> retrieveCurrentModuleData(QueryDocumentSnapshot module) async {

    var moduleRetrieved = Module.fromJson(module.data() as Map<String, dynamic>);

    if (moduleRetrieved == null){
      print("problema");
      return null;
    }
    else {
      if (moduleRetrieved.name == "O quê é?") moduleRetrieved.locked = false;
      moduleRetrieved.checkNewlines();
      print(moduleRetrieved.description);

      var subs = await moduleCollection
          .doc(module.id)
          .collection('submodules')
          .orderBy('id', descending: false)
          .get();
      for (var subModuleSnap in subs.docs){
        var sub = await createSubModuleFromSnapshot(subModuleSnap);
        if (sub != null) {
          if (sub.id == 0) sub.locked = false;
          sub.checkNewlines();
          moduleRetrieved.addSubModule(sub);
        }
      }
      return moduleRetrieved;
    }
  }

  Future<SubModule?> createSubModuleFromSnapshot(QueryDocumentSnapshot doc) async{

    if (doc == null) {
      return null;
    } else {
      print(doc.data().toString());
    }

    var subModuleRetrieved = SubModule.fromJson(doc.data() as Map<String, dynamic>);
    if (subModuleRetrieved == null){
      print("problema");
      return null;
    }
    else {
      print(subModuleRetrieved.name);
      return subModuleRetrieved;
    }
  }

  Future addSubModule(String userId, int subId) async {
    id = userId;
    UserData? data = await retrieveCurrentUserData(userId);
    var subs = data!.submodulesUnlocked.add(subId);
    return await userCollection
        .doc(userId)
        .set({
      'username' : data.username,
      'code' : data.code,
      'image' : data.image,
      'submodules' : subs
    });
  }
}