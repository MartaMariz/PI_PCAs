import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pi_pcas/models/module.dart';
import 'package:pi_pcas/models/submodule.dart';

class Utils{

  static List<Module> getMockedModules(){
    return [
      Module(
          name: "O que é?",
          description: 'Sabemos que parar com os episódios de ingestão alimentar compulsiva é uma das coisas mais difíceis que poderás enfrentar, contudo, a “nome da app” ajuda-te a entender que ser difícil não é o mesmo que ser impossível. \nA app começa por explicar a ingestão alimentar compulsiva e o papel da regulação emocional. Nos módulos seguintes serão disponibilizadas competências de mindfulness, regulação emocional e de tolerância ao sofrimento que deverão ser praticadas diariamente. \n No final dos módulos terás aprendido e praticado estratégias/competências que te permitirão enfrentar eficazmente as dificuldades e emoções intensas sem recorreres a estratégias destrutivas como a ingestão alimentar compulsiva. ',
          submodules: [
            SubModule(name: "oi", content: ["oi"], description: "oi", locked: false, favorite: false),

            SubModule(
                name: "name",
                description: "description",
                content: [],
                locked: false,
                favorite: false)
          ],
        locked: false

      ),
      Module(
          name: "Mindfulness",
          submodules: [], description: ''
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