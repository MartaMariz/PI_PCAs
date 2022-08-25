import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/models/module.dart';
import 'package:pi_pcas/models/submodule.dart';
import 'package:pi_pcas/services/database.dart';
import 'package:pi_pcas/view/pages/module/submodules_list_view.dart';
import 'package:provider/provider.dart';

import '../../../models/app_user.dart';
import '../../../theme.dart';
import 'content_view.dart';
import 'exercise_view.dart';
import 'feedback_view.dart';

class SubModuleView extends StatefulWidget{
  final SubModule subModule;
  final Module module;

  const SubModuleView( {Key? key, required this.subModule, required this.module})
      : super(key: key);

  @override
  _SubModuleView createState() => _SubModuleView();

}

class _SubModuleView extends State<SubModuleView>{

  final DatabaseService _database = DatabaseService();
  late var user;


  Future redirectToNextPage() async{
    //na seguinte ordem: content, exercise, feedback


    if (widget.subModule.hasContent){
      widget.subModule.checkImages();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContentView(
              subModule : widget.subModule, module: widget.module, index: 0),
          )
      );
    }
    else if (widget.subModule.hasExercise){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExerciseView(module: widget.module, subModule : widget.subModule),
          )
      );
    }
    else {
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

  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubModuleListView(module: widget.module))
                );
              },
            );
          },
        ),
        backgroundColor: mainColor,
      ),
      body: SafeArea(
          child: Stack(
              children : [
                Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.subModule.description,
                            style: mainTextStyle,),
                          const SizedBox(height: 200,)
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
                        onPressed: redirectToNextPage,
                        color: mainColor,
                        textColor: Colors.white,
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 24,
                        ),
                        padding: const EdgeInsets.all(16),
                        shape: const CircleBorder(),
                      )],
                    ),
                  ),
                ),
              ]
          )
      ),

    );
  }

}