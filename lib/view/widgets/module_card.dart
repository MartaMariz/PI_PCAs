import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/module.dart';
import '../../theme.dart';
import '../pages/module_view.dart';

class ModuleCard extends StatelessWidget{

  final Module module;

  const ModuleCard(this.module, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () async {
        if (module.locked){
          showDialog(context: context,
              builder: (_) =>  const AlertDialog(
                title: Text('Ainda não desbloqueaste este módulo'),
                content: Text('Completa os módulos anteriores para poderes aceder a este conteúdo. Boa sorte!'),
              ),
          barrierDismissible: true)
          ;
        }
        else {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ModulePage(module: module,),));
        }
      },
      child: Container(
        margin:const EdgeInsets.all(15),
        height: 90,
        child: Stack(
          children: [
            Positioned.fill(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: mainColor.withOpacity(.75),
                    )
                )
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin:Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(.1),
                            Colors.transparent
                          ]
                      )
                  ),
                )
            ),
            Positioned(
              left: 15,
              top:30,
              child: Text(
                  module.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish',
                    fontSize: 21,
                  )
              ),
            ),
            Positioned(
                right: 15,
                top:30,
                child: getIcon(module)
            )
          ],
        )
      )
    );
  }


  Widget getIcon(Module mod){
    if (mod.locked) {
      return const Icon(Icons.lock, color: Colors.white);
    } else {
      return const Text("");
    }
  }
}