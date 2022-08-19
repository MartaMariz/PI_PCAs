import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/models/module.dart';
import 'package:pi_pcas/view/pages/submodules_list_view.dart';
import 'package:pi_pcas/view/pages/wrapper.dart';

import '../../theme.dart';

class ModulePage extends StatefulWidget{
  final Module module;

  const ModulePage( {Key? key, required this.module}) : super(key: key);

  @override
  _ModulePage createState() => _ModulePage();

}

class _ModulePage extends State<ModulePage>{


  Future showSubModuleList() async{
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SubModuleListView(module : widget.module),
          )
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        centerTitle: true,
        title: Text(widget.module.name, style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Mulish',
          fontSize: 20.0,
        ),),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Wrapper())
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
                  Text(widget.module.description,
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
                    onPressed: showSubModuleList,
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