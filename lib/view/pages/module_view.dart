
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/models/module.dart';
import 'package:pi_pcas/view/pages/submodels_list_view.dart';
import 'package:pi_pcas/view/widgets/submodel_card.dart';

import '../../theme.dart';
import '../widgets/module_card.dart';
import 'home_page_view.dart';

class ModulePage extends StatefulWidget{
  final Module module;

  const ModulePage( {Key? key, required this.module}) : super(key: key);

  @override
  _ModulePage createState() => _ModulePage();

}

class _ModulePage extends State<ModulePage>{


  Future showSubmodelList() async{
    //usar os controllers.text e tals

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SubmodelListView(module : widget.module),
          )
      );
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        centerTitle: true,
        title: Text(widget.module.name, style: const TextStyle(color: Colors.white,
          fontFamily: 'Mulish',
          fontSize: 20.0,
        ),),
        backgroundColor: mainColor,
      ),
      body: SafeArea(
        child: Column(
          children : [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  const SizedBox(height: 50,),
                  Text(widget.module.description,
                style: mainTextStyle,),
                ]
            )
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [MaterialButton(
                onPressed: showSubmodelList,
                color: mainColor,
                textColor: Colors.white,
                child: const Icon(
                  Icons.arrow_forward,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              )],
            ),
            const SizedBox( height: 50,),
          ]
        )
      ),

    );
  }

}