import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pi_pcas/models/app_user.dart';

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
  final CollectionReference exerciseCollection = FirebaseFirestore.instance.collection('exercise');
  final CollectionReference feedbackCollection = FirebaseFirestore.instance.collection('feedback');

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

  Future<List<Module>> retrieveAllCurrentModules(String userId) async {
    List<Module> result = [];

    var userData = await retrieveCurrentUserData(userId);

    var modules = await moduleCollection.orderBy("id").get();
    for (var moduleSnap in modules.docs){
      var mod = await retrieveCurrentModuleData(moduleSnap, userData!.submodulesUnlocked);
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
        data['description'],
        data['finalMessage']
    );
  }

  Future<UserData?> retrieveCurrentUserData(String id) async {
    var doc = await userCollection
        .doc(id)
        .get();

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

  Future<Module?> retrieveCurrentModuleData(QueryDocumentSnapshot module,
      List<dynamic> submodulesUnlocked) async {

    var moduleRetrieved = Module.fromJson(module.data() as Map<String, dynamic>);

    if (moduleRetrieved == null){
      print("problema");
      return null;
    }
    else {
      moduleRetrieved.checkNewlines();

      var subs = await moduleCollection
          .doc(module.id)
          .collection('submodules')
          .orderBy('id', descending: false)
          .get();
      var oneLocked = false;
      var oneUnlocked = false;
      for (var subModuleSnap in subs.docs){
        var sub = await createSubModuleFromSnapshot(subModuleSnap);
        if (sub != null) {
          if (submodulesUnlocked.contains(sub.id)) {
            sub.locked = false;
            oneUnlocked = true;
          } else { oneLocked = true; }
          sub.checkNewlines();
          moduleRetrieved.addSubModule(sub);
        }
      }
      if(!oneLocked) moduleRetrieved.done = true;
      if(oneUnlocked) moduleRetrieved.locked = false;
      return moduleRetrieved;
    }
  }

  Future<SubModule?> createSubModuleFromSnapshot(QueryDocumentSnapshot doc) async{

    var subModuleRetrieved = SubModule.fromJson(doc.data() as Map<String, dynamic>);
    if (subModuleRetrieved == null){
      print("problema");
      return null;
    }
    else {
      if (subModuleRetrieved.hasContent){
        subModuleRetrieved.addContent(doc.data() as Map<String, dynamic>);
      }
      if (subModuleRetrieved.hasExercise){
        subModuleRetrieved.addExercise(doc.data() as Map<String, dynamic>);
      }
      return subModuleRetrieved;
    }
  }

  Future addSubModule(String userId, int subId) async {
    id = userId;
    UserData? data = await retrieveCurrentUserData(userId);
    if (data == null) return;
    if (!data.submodulesUnlocked.contains(subId+1)) data.submodulesUnlocked.add(subId+1);
    return await userCollection
        .doc(userId)
        .set({
      'username' : data.username,
      'code' : data.code,
      'image' : data.image,
      'submodules' : data.submodulesUnlocked
    });
  }

  Future updateUserData(String userId, String username, int image, String code,
      List<dynamic> submodules) async {
    id = userId;
    return await userCollection
        .doc(userId)
        .set({
      'username' : username,
      'code' : code,
      'image' : image,
      'submodules' : submodules,
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

  Future updateEmotionRecordData(String userCode, String day, String diary,
      String feeling, String module) async {
    return await recordCollection
        .doc(userCode+"-"+day+"-"+"Diário")
        .set({
      'user': userCode,
      'day': day,
      'feeling' : feeling,
      'diary': diary,
      'modulePracticed': module
    });
  }

  Future updateExerciseData(String userId, int subModId, String response,
      String subModName) async {
    id = userId;
    var userData = await retrieveCurrentUserData(userId);
    if (userData == null) return null;
    return await exerciseCollection
        .doc(userData.code+"-SubCompetência " + subModId.toString())
        .set({
      'user' : userData.code,
      'answer' : response,
      'subCompetência' : subModName
    });
  }

  Future updateFeedbackData(String userId, int subModId, String utility,
      String feeling, String response, String subModName) async {
    id = userId;
    var userData = await retrieveCurrentUserData(userId);
    if (userData == null) return null;
    return await feedbackCollection
        .doc(userData.code+"-SubCompetência " + subModId.toString())
        .set({
      'user' : userData.code,
      'feeling' : feeling,
      'utility' : utility,
      'willBeUseful' : response,
      'subCompetência' : subModName
    });
  }

}