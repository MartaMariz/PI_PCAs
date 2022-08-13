import 'submodule.dart';

class Module {
  String name;
  List<SubModule> submodules;
  bool locked;
  String description;
  bool done;

  Module({
    required this.name,
    required this.description,
    required this.submodules,
    this.locked = true,
    this.done = false
  });

  static Module fromJson(Map<String, dynamic> json) => Module(
        name: json['name'],
        description: json['description'],
        submodules: json['submodels'],
        locked: true
  );

  void checkLocks(){
    for (int i=0; i<submodules.length-1; i++){
      if (submodules[i].done && submodules[i+1].locked){
        submodules[i+1].locked = false;
      }
    }
  }

  void checkFinal(int id){
    if(id == submodules.last.id) done = true;
  }

}