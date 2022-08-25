import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/models/module.dart';
import 'package:pi_pcas/models/submodule.dart';
import 'package:pi_pcas/services/database.dart';
import 'package:pi_pcas/view/pages/module/submodules_list_view.dart';
import 'package:provider/provider.dart';

import '../../../models/app_user.dart';
import '../../../theme.dart';
import 'feedback_view.dart';

class ExerciseView extends StatefulWidget{
  final SubModule subModule;
  final Module module;

  const ExerciseView( {Key? key, required this.subModule, required this.module}) : super(key: key);

  @override
  _ExerciseView createState() => _ExerciseView();

}

class _ExerciseView extends State<ExerciseView>{

  final _responseController = TextEditingController();
  final DatabaseService _database = DatabaseService();
  late AppUser user;

  Future redirectToNextPage(String id) async{
    await _database.updateExerciseData(id, widget.subModule.id,
        _responseController.text, widget.subModule.name);

    widget.subModule.done = true;
    widget.module.checkLocks();
    widget.module.checkFinal(widget.subModule.id);
    _database.addSubModule(user.id, widget.subModule.id);
    widget.module.name == "O quê é?"?
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SubModuleListView(module: widget.module))
    ) :
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FeedbackView(module: widget.module, subModule: widget.subModule))
    );
  }

  @override
  void dispose() {
    _responseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context)!;
    double height = MediaQuery.of(context).size.height;

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
                                Text(widget.subModule.exercise!,
                                  style: mainTextStyle,),
                                const SizedBox(height: 50,),
                                //response input
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          border: Border.all(color: mainColor),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child:  Padding(
                                            padding: const EdgeInsets.only(left: 20.0),
                                            child: TextFormField(
                                              controller: _responseController,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                  hintText: 'Resposta'
                                              ),
                                            )
                                        )
                                    )
                                ),
                              ]
                          )
                      ),

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
                      Icons.arrow_forward,
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

}