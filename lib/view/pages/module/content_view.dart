import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smile/models/module.dart';
import 'package:smile/models/submodule.dart';
import 'package:smile/services/database.dart';
import 'package:smile/view/pages/module/submodules_list_view.dart';
import 'package:provider/provider.dart';

import '../../../models/app_user.dart';
import '../../../theme.dart';
import 'exercise_view.dart';
import 'feedback_view.dart';


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
    //na seguinte ordem: content restante, exercise, feedback

    if (widget.index != widget.subModule.content!.length-1){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContentView(
              subModule : widget.subModule, module: widget.module, index: widget.index+1),
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
      widget.module.name == "Porquê a SMILE - Stop Emotional Eating?"?
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
      ),

    );
  }

}