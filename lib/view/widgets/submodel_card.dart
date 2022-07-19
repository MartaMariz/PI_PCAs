import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/models/submodule.dart';
import 'package:pi_pcas/view/pages/home_page_view.dart';

import '../../models/submodule.dart';
import '../../theme.dart';

class SubModuleCard extends StatelessWidget{

  SubModule subModule;

  SubModuleCard(this.subModule, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () async {
        if (subModule.locked){
          showDialog(context: context,
              builder: (_) =>  const AlertDialog(
                title: Text('Ainda não desbloqueaste este submódulo'),
                content: Text('Completa os submódulos anteriores para poderes aceder a este conteúdo, boa sorte!'),
              ),
              barrierDismissible: true)
          ;
        }
        else {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) =>const MyHomePage(),));

        }
      },
      child: Container(
          margin:EdgeInsets.all(15),
          height: 90,
          child: Stack(
            children: [
              Positioned.fill(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: mainColor.withOpacity(0.5),
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
                    this.subModule.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Mulish',
                      fontSize: 12,
                    )
                ),
              ),
              Positioned(
                  right: 25,
                  top:30,
                  child: getIcon(this.subModule)
              )
            ],
          )
      ),
    );
  }


  Widget getIcon(SubModule mod){
    if (mod.locked) return Icon(Icons.lock, color: Colors.white);
    else return Text("");
  }
}