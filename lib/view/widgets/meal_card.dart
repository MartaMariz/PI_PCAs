import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/meal.dart';
import '../../theme.dart';

class MealCard extends StatefulWidget {
  MealCard({Key? key, required this.meal}) : super(key: key);

  final Meal meal;
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
  TextEditingController food = TextEditingController(text: "");
  late DateTime day = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  TextEditingController time = TextEditingController(text: "Escolha hora");
  late int feeling;
  late int share;

  @override
  void initState(){
    super.initState();
    skipped = false;
    feeling = 0;
    share = 0;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //print(time.format(context));
    return Container(
        child: Padding(
          padding: EdgeInsets.all(15),
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
                                setState(() => time.text = value.format(context));
                              }
                            });
                          },
                          child: Text(time.text,
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
                          child: TextField(
                            controller: food,
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
                                    return IconSlider(emotions[index], index);
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
                                    return IconSlider(shares[index], index);
                                  }
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ],
          )
        )
    );
  }

  Widget IconSlider(String emotion, int index) {
    return GestureDetector(
        onTap: () {setState(() => feeling = index);},
        child: Padding(
          padding: const EdgeInsets.all(4),
          child:
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(
                  color: feeling == index ?
                  mainColor : Colors.white,
                  blurRadius: 1.5,
                  spreadRadius: 1.5)],
            ),
            child: Image.asset(emotion, width: 80,),
          ),
        )

    );
  }
}

