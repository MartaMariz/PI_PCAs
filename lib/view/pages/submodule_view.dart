import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/models/module.dart';
import 'package:pi_pcas/models/submodule.dart';
import 'package:pi_pcas/view/pages/submodules_list_view.dart';

import '../../theme.dart';

class SubModulePage extends StatefulWidget{
  final SubModule subModule;
  final Module module;

  const SubModulePage( {Key? key, required this.subModule, required this.module}) : super(key: key);

  @override
  _SubModulePage createState() => _SubModulePage();

}

class _SubModulePage extends State<SubModulePage>{


  Future redirectToNextPage() async{
    //na seguinte ordem: content, exercise, pop

    widget.subModule.done = true;
    widget.module.checkLocks();
    widget.module.checkFinal(widget.subModule.id);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SubModuleListView(module: widget.module))
    );
/*
    if (widget.subModule.hasContent){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContentView(subModule : widget.subModule, index: 0),
          )
      );
    }
    else if (widget.subModule.hasExercise){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExerciseView(subModule : widget.subModule),
          )
      );
    }
    else {
      widget.subModule.done = true;
      widget.module.checkLocks();
      widget.module.checkFinal(widget.subModule.id);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SubModuleListView(module: widget.module))
      );
    }

 */
  }

  @override
  Widget build(BuildContext context) {
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
                        child: widget.subModule.hasContent || widget.subModule.hasExercise?
                        const Icon(
                          Icons.arrow_forward,
                          size: 24,
                        ) : const Icon(
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
          )
      ),

    );
  }

}