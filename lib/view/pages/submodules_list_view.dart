
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/models/module.dart';
import 'package:pi_pcas/theme.dart';
import 'package:pi_pcas/view/pages/module_view.dart';
import 'package:pi_pcas/view/widgets/submodel_card.dart';

import '../widgets/module_card.dart';


class SubModuleListView extends StatefulWidget{
  final Module module;

  const SubModuleListView( {Key? key, required this.module}) : super(key: key);

  @override
  _SubModuleListView createState() => _SubModuleListView();
}


class _SubModuleListView extends State<SubModuleListView>{

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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ModulePage(module: widget.module))
                );
              },
            );
          },
        ),
        backgroundColor: mainColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
              child: ListView.builder(
                itemCount: widget.module.submodules.length,
                itemBuilder: (BuildContext ctx, int index){
                  return SubModuleCard(widget.module, widget.module.submodules[index]);
                },
              )
          ),
        ],
      ),
    );
  }

}
