import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smile/services/database.dart';
import 'package:provider/provider.dart';

import '../../models/app_user.dart';
import '../../models/user_data.dart';
import '../../theme.dart';

class MealCard extends StatefulWidget {
  MealCard({Key? key, required this.meal, required this.day}) : super(key: key);

  final String meal;
  final String day;
  bool selected = false;


  @override
  _MealCardState createState() => _MealCardState();
}

class _MealCardState extends State<MealCard>{

  List<String> emotionsPath = [
    "lib/assets/images/happy_emotion.png",
    "lib/assets/images/guilt_emotion.png",
    "lib/assets/images/motivated_emotion.png",
    "lib/assets/images/anxious_emotion.png",
    "lib/assets/images/alone_emotion.png",
    "lib/assets/images/satisfied_emotion.png",
    "lib/assets/images/shame_emotion.png",
    "lib/assets/images/mad_emotion.png",
    "lib/assets/images/proud_emotion.png",
    "lib/assets/images/sad_emotion.png"
  ];

  List<String> sharesPath = [
    "lib/assets/images/alone_share.png",
    "lib/assets/images/family_share.png",
    "lib/assets/images/friends_share.png",
    "lib/assets/images/so_share.png",
    "lib/assets/images/coworkers_share.png"
  ];

  List<String> emotions = [
    "Feliz",
    "Culpada",
    "Motivada",
    "Ansiosa",
    "Sozinha",
    "Satisfeita",
    "Vergonha",
    "Irritada",
    "Orgulhosa",
    "Triste"
  ];

  List<String> shares = [
    "Sozinha",
    "Família",
    "Amigos",
    "Parceiro/a",
    "Colegas"
  ];

  List<String> behaviours = [
    "Exercício físico excessivo",
    "Vomitar",
    "Tomar laxantes",
    "Tomar medicação para emagrecer",
    "Mastigar e cuspir",
    "Esconder comida",
    "Contar calorias"
  ];

  late bool skipped;
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _timeController = TextEditingController(text: "Escolha hora");
  late int feeling;
  late int share;
  late bool restrict;
  late bool quantity;
  late bool control;
  late bool behaviour;
  late int compensation;

  late AppUser user;
  final DatabaseService _database = DatabaseService();

  @override
  void initState(){
    super.initState();
    skipped = false;
    restrict = false;
    quantity = false;
    control = false;
    behaviour = false;
    feeling = -1;
    share = -1;
    compensation = -1;
  }

  Future sendData() async{
    String userCode = "";
    UserData? userInfo = await _database.retrieveCurrentUserData(user.id);
    if (userInfo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Houve um problema ao recolher dados. Tente novamente mais tarde.')),
      );
      return;
    } else {
      userCode = userInfo.code;
    }

    if ((_timeController.text != "Escolha hora" && feeling != -1 && share != -1
        && _foodController.text.isNotEmpty &&
        ((behaviour && compensation != -1) || !behaviour)) || skipped) {
      await _database.updateRecordData(
          userCode,
          skipped,
          _timeController.text,
          widget.day,
          widget.meal,
          feeling == -1? "" : emotions[feeling],
          share == -1? "" : shares[share],
          _foodController.text,
          restrict,
          quantity,
          control,
          behaviour,
          compensation == -1? "" : behaviours[compensation]
      );
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Obrigada!'),
              content: Text("A tua refeição foi enviada com sucesso."),
            );
          });
    }
    else {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Oops!'),
              content: Text("Deves preencher os campos todos se quiseres enviar os dados."),
            );
          });
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    user = Provider.of<AppUser?>(context)!;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              const Text("Saltei esta refeição",
                style: TextStyle(color: textGrayColor, fontSize: 15)
                ,),
              const Spacer(),
              Checkbox(value: skipped,
                      onChanged: (b) {
                setState(() => (skipped = b!));}
              )
            ],
          ),
          if(!skipped)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Quando comi",
                      style: TextStyle(color: textGrayColor, fontSize: 15)
                      ,),
                    const Spacer(),
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        elevation: MaterialStateProperty.all<double>(0.0),
                        shadowColor: MaterialStateProperty.all<Color>(mainColor),
                      ),
                      onPressed: () async {
                        await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, child) {
                          return Theme(
                              data: ThemeData.light().copyWith(
                              primaryColor: const Color(0xFFB48DE5),
                              accentColor: const Color(0xFFB48DE5),
                              colorScheme: const ColorScheme.light(primary: Color(0xFFB48DE5)),
                              buttonTheme: const ButtonThemeData(
                              textTheme: ButtonTextTheme.primary
                              ),
                              ), child: child!,
                          );},
                        ).then((value) {
                          if(value != null) {
                            setState(() => _timeController.text = value.format(context));
                          }
                        });
                      },
                      child: Text(_timeController.text,
                        style: const TextStyle(color: textGrayColor, fontSize: 15)
                        ,),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("O que comi e bebi",
                      style: TextStyle(color: textGrayColor, fontSize: 15),),
                    const Spacer(),
                    SizedBox(
                      width: width/3+width/7,
                      height: 80,
                      child: TextFormField(
                        validator: (value) {
                          if ((value == null || value.isEmpty) && !skipped){
                            return 'Deve inserir a refeição se não a saltou';
                          }
                          return null;
                        },
                        controller: _foodController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                        ),
                      )
                    )
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,5,0,5),
                      child: Text("Como me senti",
                        textAlign: TextAlign.start,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(color: textGrayColor, fontSize: 15)
                        ,),
                    ),
                    Spacer()
                  ],
                ),
                SizedBox(
                  width: width-20,
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                              itemCount: emotionsPath.length,
                              itemBuilder: (BuildContext ctx, int index){
                                return iconSlider(emotionsPath[index], index, true);
                              }
                          )
                      ),
                    ],
                  ),
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,5,0,5),
                      child: Text("Com quem partilhei a refeição",
                        textAlign: TextAlign.start,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(color: textGrayColor, fontSize: 15)
                        ,),
                    ),
                    Spacer()
                  ],
                ),
                SizedBox(
                  width: width-20,
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: sharesPath.length,
                              itemBuilder: (BuildContext ctx, int index){
                                return iconSlider(sharesPath[index], index, false);
                              }
                          )
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Text("Restringi a quantidade de alimentos?",
                      style: TextStyle(color: textGrayColor, fontSize: 15)
                      ,),
                    const Spacer(),
                    Checkbox(value: restrict,
                        onChanged: (b) {
                          setState(() => (restrict = b!));}
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text("Comi uma grande quantidade de alimentos?",
                      style: TextStyle(color: textGrayColor, fontSize: 15)
                      ,),
                    const Spacer(),
                    Checkbox(value: quantity,
                        onChanged: (b) {
                          setState(() => (quantity = b!));}
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text("Senti falta de controlo enquanto comia?",
                      style: TextStyle(color: textGrayColor, fontSize: 15)
                      ,),
                    const Spacer(),
                    Checkbox(value: control,
                        onChanged: (b) {
                          setState(() => (control = b!));}
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text("Recorri a um comportamento para compensar?",
                      style: TextStyle(color: textGrayColor, fontSize: 14)
                      ,),
                    const Spacer(),
                    Checkbox(value: behaviour,
                        onChanged: (b) {
                          setState(() => (behaviour = b!));}
                    )
                  ],
                ),
                if(behaviour)
                  Column(
                    children: [
                      SizedBox(
                        width: width-25,
                        height: 150,
                        child: Column(
                          children: [
                            Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: behaviours.length,
                                    itemBuilder: (BuildContext ctx, int index){
                                      return listBehaviours(behaviours[index], index);
                                    }
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ],
            ),

          //enviar button
          Padding(padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: sendData,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(150, 10, 150, 10),
                  decoration:  BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                      'Enviar',
                      style: TextStyle(
                          color:  Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      )
                  )
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget iconSlider(String emotion, int index, bool isFeeling) {
    return GestureDetector(
        onTap: () {setState(() => isFeeling? feeling = index : share = index);},
        child: Padding(
          padding: const EdgeInsets.all(4),
          child:
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(
                  color: isFeeling?
                    (feeling == index ?
                    mainColor : Colors.white) :
                    (share == index ?
                    mainColor : Colors.white),
                  blurRadius: 1.5,
                  spreadRadius: 1.5)],
            ),
            child: Image.asset(emotion, width: 80,),
          ),
        )

    );
  }

  Widget listBehaviours(String b, int index) {
    return GestureDetector(
        onTap: () {setState(() {
          compensation = index;
        });},
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(b,
            style: TextStyle(color: compensation == index?
            mainColor : textGrayColor, fontSize: 15),
          ),
        )
    );
  }

}

