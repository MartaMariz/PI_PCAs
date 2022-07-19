
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/models/module.dart';
import 'package:pi_pcas/helpers/utils.dart';
import 'package:pi_pcas/theme.dart';
import 'package:pi_pcas/view/widgets/submodel_card.dart';

import '../widgets/module_card.dart';


class SubmodelListView extends StatefulWidget{
  final Module module;

  const SubmodelListView( {Key? key, required this.module}) : super(key: key);


  @override
  _SubmodelListView createState() => _SubmodelListView();

}


class _SubmodelListView extends State<SubmodelListView>{

  @override
  void initState(){
    super.initState();
    //DatabaseReference referenceModules = FirebaseDatabase.instance.reference().child("module");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        centerTitle: true,
        title:  Text(widget.module.name, style: const TextStyle(
            fontSize: 20.0,
            fontFamily: 'Mulish',
            color: Colors.white),),
        backgroundColor: mainColor,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
                child: ListView.builder(
                  itemCount: widget.module.submodules.length,
                  itemBuilder: (BuildContext ctx, int index){
                    return SubModuleCard(widget.module.submodules[index]);
                  },
                )
            ),
          ],
        ),
      ),
    );
  }

}
