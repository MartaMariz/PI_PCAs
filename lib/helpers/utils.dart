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
          description: 'Sabemos que parar com os episódios de ingestão alimentar compulsiva é uma das coisas mais difíceis que poderás enfrentar, contudo, a “nome da app” ajuda-te a entender que ser difícil não é o mesmo que ser impossível. \nA app começa por explicar a ingestão alimentar compulsiva e o papel da regulação emocional. Nos módulos seguintes serão disponibilizadas competências de mindfulness, regulação emocional e de tolerância ao sofrimento que deverão ser praticadas diariamente. \n No final dos módulos terás aprendido e praticado estratégias/competências que te permitirão enfrentar eficazmente as dificuldades e emoções intensas sem recorreres a estratégias destrutivas como a ingestão alimentar compulsiva.',
          submodules: [
            SubModule(
                name: "Episódio de Ingestão Alimentar Compulsiva – o que é?",
                description: "Os episódios de ingestão alimentar compulsiva são caracterizados por: \n1.	Comer, num período curto de tempo (por exemplo, um período de até 2 horas), uma quantidade de alimentos que é sem dúvida superior à que a maioria dos indivíduos comeria num período de tempo semelhante e nas mesmas circunstâncias; \n2.	Sensação de perda de controlo sobre o ato de comer durante o episódio (por exemplo, sentimento de incapacidade para parar de comer ou controlar a quantidade e qualidade nos alimentos).",
                locked: false,
                favorite: false,
                hasExercise: false,
                hasContent: false,
                id: 0),
            SubModule(
                name: "Comportamento Compensatório Inapropriado – o que é?",
                description: "description",
                locked: true,
                favorite: false,
                hasExercise: false,
                hasContent: false,
                id: 1),
            SubModule(
                name: "O Modelo de Regulação Emocional: A Ligação entre as Emoções e a Ingestão Alimentar Compulsiva",
                description: "description",
                locked: true,
                favorite: false,
                hasExercise: false,
                hasContent: false,
                id: 2),
            SubModule(
                name: "A Teoria Biossocial para a Regulação Emocional",
                description: "description",
                locked: true,
                favorite: false,
                hasExercise: false,
                hasContent: false,
                id: 3),
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