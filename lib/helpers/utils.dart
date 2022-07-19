import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pi_pcas/models/app_user.dart';
import 'package:pi_pcas/models/module.dart';
import 'package:pi_pcas/models/submodule.dart';

class Utils{


  late AppUser user;
  static List<Module> getMockedModules(){
    return [
      Module(
          name: "O que é?",
          description: 'Sabemos que parar com os episódios de ingestão alimentar compulsiva é uma das coisas mais difíceis que poderás enfrentar, contudo, a “nome da app” ajuda-te a entender que ser difícil não é o mesmo que ser impossível. \nA app começa por explicar a ingestão alimentar compulsiva e o papel da regulação emocional. Nos módulos seguintes serão disponibilizadas competências de mindfulness, regulação emocional e de tolerância ao sofrimento que deverão ser praticadas diariamente. \n No final dos módulos terás aprendido e praticado estratégias/competências que te permitirão enfrentar eficazmente as dificuldades e emoções intensas sem recorreres a estratégias destrutivas como a ingestão alimentar compulsiva. ',
          submodules: [
            SubModule(name: "Episódio de Ingestão Alimentar Compulsiva – o que é?", content: ["oi"], description: "oi", locked: false, favorite: false),

            SubModule(
                name: "Comportamento Compensatório Inapropriado – o que é?",
                description: "description",
                content: [],
                locked: true,
                favorite: false),
            SubModule(
                name: "O Modelo de Regulação Emocional: A Ligação entre as Emoções e a Ingestão Alimentar Compulsiva",
                description: "description",
                content: [],
                locked: true,
                favorite: false),
            SubModule(
                name: "A Teoria Biossocial para a Regulação Emocional",
                description: "description",
                content: [],
                locked: true,
                favorite: false),
            SubModule(
                name: "A Teoria Biossocial para a Regulação Emocional",
                description: "description",
                content: [],
                locked: true,
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