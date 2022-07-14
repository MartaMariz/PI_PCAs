import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pi_pcas/models/module.dart';

class Utils{
  static List<Module> getMockedModules(){
    return [
      Module(
          name: "Oque é?",
          submodules: []
      ),
      Module(
          name: "Mindfulness",
          submodules: []
      ),
    ];
  }



  Stream<List<Module>> readModules() {
   return FirebaseFirestore.instance
      .collection('module')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) =>
          Module.fromJson(doc.data())).toList());
 }
}