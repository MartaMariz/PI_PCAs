import 'package:flutter/material.dart';
import 'package:smile/models/module.dart';
import 'package:smile/theme.dart';
import 'package:provider/provider.dart';

import '../../../models/app_user.dart';
import '../../../services/database.dart';
import '../../widgets/module_card.dart';
import '../../../theme.dart';


class Modules extends StatefulWidget{
  const Modules({Key? key}) : super(key: key);

  @override
  _ModulesState createState() => _ModulesState();

}


class _ModulesState extends State<Modules>{
  List<Module> _modules = [];
  bool dataRead = false;
  final DatabaseService _database = DatabaseService();

  Future getData(String userId) async {
    var data = await _database.retrieveAllCurrentModules(userId);
    setState(() {
      _modules = data;
      dataRead = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppUser user = Provider.of<AppUser?>(context)!;
    getData(user.id);
    checkLocks();
    build(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('SMILE', style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Mulish',
            color: Colors.white),),
        backgroundColor: mainColor,
      ),
      body: !dataRead ? const Center(
        child: CircularProgressIndicator(
          color: mainColor,
          strokeWidth: 5,
        ),
      ) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Expanded(
              child: ListView.builder(
                itemCount: _modules.length,
                itemBuilder: (BuildContext ctx, int index){
                  return ModuleCard(_modules[index]);
                },
              )
          ),
        ],
      ),
    );
  }

  void checkLocks(){
    for (int i=0; i<_modules.length-1; i++){
      if (_modules[i].done && _modules[i+1].locked){
        _modules[i+1].locked = false;
      }
    }
  }

}
