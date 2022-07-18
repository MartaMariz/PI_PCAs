
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/models/module.dart';
import 'package:pi_pcas/view/widgets/submodel_card.dart';

import '../../theme.dart';
import '../widgets/module_card.dart';

class ModulePage extends StatefulWidget{
  final Module module;

  const ModulePage( {Key? key, required this.module}) : super(key: key);

  @override
  _ModulePage createState() => _ModulePage();

}


class _ModulePage extends State<ModulePage>{

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(widget.module.description,
              style: mainTextStyle,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.module.submodules.length,
                  itemBuilder: (BuildContext ctx, int index){
                    return SubModuleCard(widget.module.submodules[index]);
                  },
                )

          ],
        ),
      ),
    );
  }

}