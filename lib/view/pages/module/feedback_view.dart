import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/view/pages/module/submodules_list_view.dart';
import 'package:provider/provider.dart';

import '../../../models/app_user.dart';
import '../../../models/module.dart';
import '../../../models/submodule.dart';
import '../../../services/database.dart';
import '../../../theme.dart';

class FeedbackView extends StatefulWidget{
  final SubModule subModule;
  final Module module;

  const FeedbackView( {Key? key, required this.subModule, required this.module}) : super(key: key);

  @override
  _FeedbackView createState() => _FeedbackView();

}

class _FeedbackView extends State<FeedbackView>{

  double _utilityController = 0;
  int _feelingController = -1;
  final _responseController = TextEditingController();

  final List<String> labels = [
    "Nem um pouco",
    "Um pouco",
    "Mais ou menos",
    "Muito",
    "Extremamente"
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

  final DatabaseService _database = DatabaseService();
  late AppUser user;


  Future redirectToNextPage(String id) async{
    if (_feelingController != -1){
        await _database.updateFeedbackData(id, widget.subModule.id,
            labels[_utilityController.toInt()], emotions[_feelingController],
            _responseController.text, widget.subModule.name);
    }

    widget.subModule.done = true;
    widget.module.checkLocks();
    widget.module.checkFinal(widget.subModule.id);
    _database.addSubModule(user.id, widget.subModule.id);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SubModuleListView(module: widget.module))
    );
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context)!;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        centerTitle: true,
        title: Text(widget.subModule.name, style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Mulish',
          fontSize: 15.0,
        ),),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        backgroundColor: mainColor,
      ),
      body: Stack(
          children: [
            SingleChildScrollView(
                child : Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Por favor responde às seguintes perguntas para sabermos o que pensas sobre esta subcompetência",
                                  style: mainTextStyle,),
                                const SizedBox(height: 50,),
                                const Text("Esta atividade foi útil?",
                                  style: mainTextStyle,),
                                Slider(
                                  value: _utilityController,
                                  onChanged: (newValue) {
                                    setState(() => _utilityController = newValue);
                                  },
                                  min: 0,
                                  max: 4,
                                  divisions: 4,
                                  activeColor: mainColor,
                                  inactiveColor: Colors.grey[200],
                                  thumbColor: Colors.grey[200],
                                  label: labels[_utilityController.toInt()]
                                ),
                                const SizedBox(height: 50,),
                                const Text("Como te sentes agora?",
                                  style: mainTextStyle,),
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
                                                return IconSlider(emotionsPath[index], index);
                                              }
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                          )
                      ),
                      const SizedBox(height: 50,),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            child: Text("Este exercício será útil quando ",
                            style: mainTextStyle)),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                            child: SizedBox(
                                width: width/4,
                                height: 80,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty){
                                      return 'Deve inserir uma resposta';
                                    }
                                    return null;
                                  },
                                  controller: _responseController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                )
                            )
                          )
                        ],
                      )
                    ]
                )
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [MaterialButton(
                    onPressed: () => redirectToNextPage(user.id),
                    color: mainColor,
                    textColor: Colors.white,
                    child: const Icon(
                      Icons.done_rounded,
                      size: 24,
                    ) ,
                    padding: const EdgeInsets.all(16),
                    shape: const CircleBorder(),
                  )],
                ),
              ),
            ),
          ]
      ),

    );
  }


  Widget IconSlider(String emotion, int index) {
    return GestureDetector(
        onTap: () {setState(() => _feelingController = index);},
        child: Padding(
          padding: const EdgeInsets.all(4),
          child:
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(
                  color: (_feelingController == index ?
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