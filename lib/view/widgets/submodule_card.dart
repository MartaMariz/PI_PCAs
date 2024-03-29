import 'package:flutter/material.dart';
import 'package:smile/models/submodule.dart';
import 'package:smile/view/pages/module/submodule_view.dart';
import '../../models/module.dart';
import '../../models/submodule.dart';
import '../../theme.dart';

class SubModuleCard extends StatelessWidget{

  final Module module;
  final SubModule subModule;

  const SubModuleCard(this.module, this.subModule, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return GestureDetector(
      onTap: () async {
        if (subModule.locked){
          showDialog(context: context,
              builder: (_) =>  const AlertDialog(
                title: Text('Ainda não desbloqueaste esta competência'),
                content: Text('Complete as competências anteriores para poderes aceder a este conteúdo. Boa sorte!'),
              ),
              barrierDismissible: true)
          ;
        }
        else {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SubModuleView(module: module, subModule: subModule)));
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
                        color: _getColorFromHex(module.color).withOpacity(0.75),
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
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SizedBox(
                    width: 300,
                    child: Text(
                        subModule.name,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Mulish',
                          fontSize: 20,
                        )
                    ),
                  ),
                ),
              ),
              Positioned(
                  right: 25,
                  top:30,
                  child: getIcon(subModule)
          )
            ]

            ,
          )
      ),
    );
  }


  Widget getIcon(SubModule mod){
    if (mod.locked) {
      return const Icon(Icons.lock, color: Colors.white);
    } else {
      return const Text("");
    }
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    else {
      return mainColor;
    }
  }
}