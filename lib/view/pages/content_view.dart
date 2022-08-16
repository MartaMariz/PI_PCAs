import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/models/module.dart';
import 'package:pi_pcas/models/submodule.dart';
import 'package:pi_pcas/services/database.dart';
import 'package:pi_pcas/view/pages/submodules_list_view.dart';
import 'package:provider/provider.dart';

import '../../models/app_user.dart';
import '../../theme.dart';

class ContentView extends StatefulWidget{
  final SubModule subModule;
  final Module module;
  final int index;

  const ContentView( {Key? key, required this.subModule, required this.module,
    required this.index}) : super(key: key);

  @override
  _ContentView createState() => _ContentView();

}

class _ContentView extends State<ContentView>{

  final DatabaseService _database = DatabaseService();
  late var user;


  Future redirectToNextPage() async{
    //na seguinte ordem: content restante, exercise, pop

    if (widget.index != widget.subModule.content!.length-1){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContentView(
              subModule : widget.subModule, module: widget.module, index: widget.index+1),
          )
      );
    }

    /*
    else if (widget.subModule.hasExercise){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExerciseView(subModule : widget.subModule),
          )
      );
    }
    */
    else {
      widget.subModule.done = true;
      widget.module.checkLocks();
      widget.module.checkFinal(widget.subModule.id);
      _database.addSubModule(user.id, widget.subModule.id);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SubModuleListView(module: widget.module))
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
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
                            Text(widget.subModule.content![widget.index],
                              style: mainTextStyle,),
                            widget.subModule.images != null
                                && widget.subModule.images!.containsKey(widget.index) ?
                            Image(image: ExactAssetImage(
                                "lib/assets/images/contents/" +
                                    widget.subModule.images![widget.index]!))
                                : const Text(""),
                            const SizedBox(height: 100,),
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
                    onPressed: redirectToNextPage,
                    color: mainColor,
                    textColor: Colors.white,
                    child: widget.index != widget.subModule.content!.length-1
                        || widget.subModule.hasExercise?
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
      ),

    );
  }

}