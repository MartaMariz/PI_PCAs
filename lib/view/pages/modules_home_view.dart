import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/models/module.dart';
import 'package:pi_pcas/helpers/utils.dart';
import 'package:pi_pcas/theme.dart';

import '../widgets/module_card.dart';


class Modules extends StatefulWidget{
  const Modules({Key? key}) : super(key: key);

  @override
  _ModulesState createState() => _ModulesState();

}


class _ModulesState extends State<Modules>{
  List<Module> modules = Utils.getMockedModules();

  @override
  void initState(){
    super.initState();
    //DatabaseReference referenceModules = FirebaseDatabase.instance.reference().child("module");
  }

  @override
  Widget build(BuildContext context) {
    checkLocks();
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        centerTitle: true,
        title: const Text('Conteúdo', style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Mulish',
            color: Colors.white),),
        backgroundColor: mainColor,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: OutlinedButton(

                style: TextButton.styleFrom(
                  primary: mainColor,
                  onSurface: mainColor,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                ),
                child: const Text('Favoritos',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Mulish',
                    color: mainColor),
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: modules.length,
                  itemBuilder: (BuildContext ctx, int index){
                    return ModuleCard(modules[index]);
                  },
                )
            ),
          ],
        ),
      ),
    );
  }

  void checkLocks(){
    for (int i=0; i<modules.length-1; i++){
      if (modules[i].done && modules[i+1].locked){
        modules[i+1].locked = false;
      }
    }
  }

}
