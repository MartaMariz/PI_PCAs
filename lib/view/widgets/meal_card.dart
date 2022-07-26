import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/services/database.dart';
import 'package:provider/provider.dart';

import '../../models/app_user.dart';
import '../../models/meal.dart';
import '../../theme.dart';

class MealCard extends StatefulWidget {
  MealCard({Key? key, required this.meal, required this.day}) : super(key: key);

  final Meal meal;
  final String day;
  bool selected = false;


  @override
  _MealCardState createState() => _MealCardState();
}

class _MealCardState extends State<MealCard>{

  List<String> emotions = [
    "lib/assets/images/happy_emotion.png",
    "lib/assets/images/anxious_emotion.png",
    "lib/assets/images/satisfied_emotion.png",
    "lib/assets/images/mad_emotion.png",
    "lib/assets/images/sad_emotion.png"
  ];

  List<String> shares = [
    "lib/assets/images/alone_share.png",
    "lib/assets/images/family_share.png",
    "lib/assets/images/friends_share.png",
    "lib/assets/images/so_share.png"
  ];

  late bool skipped;
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _timeController = TextEditingController(text: "Escolha hora");
  late int feeling;
  late int share;
  late AppUser user;

  final DatabaseService _database = DatabaseService();

  @override
  void initState(){
    super.initState();
    skipped = false;
    feeling = 0;
    share = 0;
  }

  Future sendData() async{
    widget.meal.day = widget.day;
    widget.meal.skipped = skipped;
    if (_timeController.text != "Escolha hora") {
      widget.meal.time = _timeController.text;
    } else {

    }
    widget.meal.share = share;
    widget.meal.feeling = feeling;
    widget.meal.food = _foodController.text;

    await _database.updateRecordData(user.id, widget.meal);
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
                  mainAxisAlignment: MainAxisAlignment.start, //change here don't //worked
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
                    const Text("O que comi",
                      style: TextStyle(color: textGrayColor, fontSize: 15)
                      ,),
                    const Spacer(),
                    SizedBox(
                      width: width/3,
                      height: 50,
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
                              itemCount: emotions.length,
                              itemBuilder: (BuildContext ctx, int index){
                                return IconSlider(emotions[index], index, true);
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
                              itemCount: shares.length,
                              itemBuilder: (BuildContext ctx, int index){
                                return IconSlider(shares[index], index, false);
                              }
                          )
                      ),
                    ],
                  ),
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

  Widget IconSlider(String emotion, int index, bool isFeeling) {
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

}

