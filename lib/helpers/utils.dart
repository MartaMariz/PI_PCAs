import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smile/models/app_user.dart';
import 'package:smile/models/module.dart';

class Utils{

  late AppUser user;

  Stream<List<Module>> readModules() {
   return FirebaseFirestore.instance
      .collection('module')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) =>
          Module.fromJson(doc.data())).toList());
 }
}