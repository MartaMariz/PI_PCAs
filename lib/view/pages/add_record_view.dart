import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/services/database.dart';
import 'package:pi_pcas/view/pages/wrapper.dart';
import 'package:provider/provider.dart';

import '../../models/app_user.dart';
import '../../models/meal.dart';
import '../../models/user_data.dart';
import '../../theme.dart';
import '../widgets/meal_card.dart';

class AddRecord extends StatefulWidget{
  @override
  _RecordState createState() => _RecordState();

}

class _RecordState extends State<AddRecord>{

  List<String> months = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];

  static List<Meal> meals = [
    Meal.incomplete("Pequeno Almoço"),
    Meal.incomplete("Lanche da Manhã"),
    Meal.incomplete("Almoço"),
    Meal.incomplete("Lanche"),
    Meal.incomplete("Jantar"),
    Meal.incomplete("Ceia")
  ];

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

  List<String> modulesPath = [
    "lib/assets/images/mindfulness_module.png",
    "lib/assets/images/emotional_module.png",
    "lib/assets/images/suffering_module.png",
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

  List<String> modules = [
    "Competências de Mindfulness",
    "Competências de Regulação Emocional",
    "Competências de Tolerância ao Sofrimento"
  ];

  int _feelingController = -1;
  int _moduleController = -1;
  int _subModuleController = -1;
  late String title;
  late double width;
  List<String> submodules = [];
  late AppUser user;
  bool dataRead = false;
  final _database = DatabaseService();


  Future sendData() async{
    String userCode = "";
    UserData? userInfo = await _database.retrieveCurrentUserData(user.id);
    if (userInfo == null) {
      print("problema retrieving info da base de dados");
    } else {
      userCode = userInfo.code;
    }
    if (_feelingController == -1 || _moduleController == -1 ||
        _subModuleController == -1){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos para enviar')),
      );
      return;
    }

    await _database.updateEmotionRecordData(userCode,
        title+" de "+DateTime.now().year.toString(),
      emotions[_feelingController], submodules[_subModuleController]);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Wrapper())
    );
  }


  void updateSubs() async{
    if (_moduleController != -1) {
      var subs = await _database.getSubmodules(modules[_moduleController]);
      setState(() {
        submodules = subs;
        dataRead = true;
      });
    }
  }

  @override
  void didChangeDependencies() {
    print("called");
    super.didChangeDependencies();
    updateSubs();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context)!;
    title = DateTime.now().day.toString() + " de " + months[DateTime.now().month-1];
    width = MediaQuery.of(context).size.width;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.clear_rounded, color: Colors.white,),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Wrapper())); },
              ),
            ],
            elevation: 0.0,
            centerTitle: true,
            title: Text(title, style: const TextStyle(color: Colors.white,
              fontFamily: 'Mulish',
              fontSize: 20.0,
            )),
            backgroundColor: mainColor,
            bottom: const TabBar(
              labelColor: Colors.white,
                tabs: [
                  Tab(
                      icon: Icon(Icons.dining_outlined),
                      text: "Diário das refeições",
                  ),
                  Tab(
                      icon: Icon(Icons.favorite),
                      text: "Diário das emoções",
                  )
                ]
            ),
          ),
          body: TabBarView(
            children: [
              //diário das refeições
              SingleChildScrollView(
                child: ExpansionPanelList.radio(
                  expandedHeaderPadding: EdgeInsets.all(0),
                  elevation: 0,
                  dividerColor: mainColor,
                  children: meals
                      .map((meal) => ExpansionPanelRadio(
                      canTapOnHeader: true,
                      value: meal.meal,
                      headerBuilder: (context, isExpanded) =>
                          ListTile(
                            title: Text(meal.meal,
                              style: const TextStyle(fontSize: 18, color: textGrayColor),),
                          ),
                      body: MealCard(meal: meal, day: title+" de "+DateTime.now().year.toString())))
                      .toList(),
                ),
              ),

              //diário das emoções
              SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Como me senti hoje",
                            style: TextStyle(color: textGrayColor, fontSize: 15),),
                          SizedBox(
                            width: width-25,
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
                          const SizedBox(height: 20,),
                          const Text("A competência que mais me ajudou hoje foi",
                            style: TextStyle(color: textGrayColor, fontSize: 15),),
                          SizedBox(
                            width: width-25,
                            height: 150,
                            child: Row(
                              children: [
                                Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: modulesPath.length,
                                        itemBuilder: (BuildContext ctx, int index){
                                          return iconSlider(modulesPath[index], index, false);
                                        }
                                    )
                                ),
                              ],
                            ),
                          ),
                          _moduleController == -1?
                              const SizedBox() :
                              !dataRead ? const Center(
                                child: CircularProgressIndicator(
                                  color: mainColor,
                                  strokeWidth: 5,
                                ),
                              ) :
                              SizedBox(
                                width: width-25,
                                height: 150,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount: submodules.length,
                                            itemBuilder: (BuildContext ctx, int index){
                                              return listSubmodules(submodules[index], index);
                                            }
                                        )
                                    ),
                                  ],
                                ),
                              ),

                          //enviar button
                          const SizedBox(height: 20,),
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
                  )
              )
            ],
          )
        )
    );
  }


  Widget iconSlider(String image, int index, bool isFeeling) {
    return GestureDetector(
        onTap: () {setState(() { if(isFeeling) {
          _feelingController = index;
        } else {
          _moduleController = index;
          print(_moduleController);
          dataRead = false;
        }});
          didChangeDependencies();
          },
        child: Padding(
          padding: const EdgeInsets.all(4),
          child:
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(
                  color: isFeeling?
                  (_feelingController == index ?
                  mainColor : Colors.white) :
                  (_moduleController == index ?
                  mainColor : Colors.white),
                  blurRadius: 1.5,
                  spreadRadius: 1.5)],
            ),
            child: Image.asset(image, width: isFeeling? 100 : width/3-18,),
          ),
        )
    );
  }

  Widget listSubmodules(String submodule, int index) {
    return GestureDetector(
        onTap: () {setState(() {
          _subModuleController = index;
        });},
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(submodule,
              style: TextStyle(color: _subModuleController == index?
                  mainColor : textGrayColor, fontSize: 15),
          ),
        )
    );
  }

}


