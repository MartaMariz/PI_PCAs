import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/module.dart';
import '../../theme.dart';

class ModuleCard extends StatelessWidget{

  Module module;

  ModuleCard(this.module);

  @override
  Widget build(BuildContext context){
    return Container(
        margin:EdgeInsets.all(15),
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
                            Colors.black.withOpacity(.2),
                            Colors.transparent
                          ]
                      )
                  ),
                )
            ),
            Positioned(
              left: 15,
              top:25,
              child: Text(
                  this.module.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish',
                    fontSize: 25,
                  )
              ),
            ),
            Positioned(
                right: 15,
                top:30,
                child: getIcon(this.module)
            )
          ],
        )
    );
  }


  Widget getIcon(Module mod){
    if (!mod.locked) return Icon(Icons.lock, color: Colors.white);
    else return Text("");
  }
}