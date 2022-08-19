import 'submodule.dart';

class Module {
  String name;
  List<SubModule> submodules = [];
  bool locked;
  String description;
  bool done;
  String finalMessage;

  Module({
    required this.name,
    required this.description,
    required this.submodules,
    required this.finalMessage,
    this.locked = true,
    this.done = false,
  });


  Module.incomplete(
    this.name,
    this.description,
    this.finalMessage,
    {
    this.locked = true,
    this.done = false,
    }
  );

  static Module fromJson(Map<String, dynamic> json) => Module.incomplete(
        json['name'],
        json['description'],
        json['finalMessage']
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

  void addSubModule(SubModule subModule) {
    submodules.add(subModule);
  }

  void checkNewlines(){
    description = description.replaceAll("\\n", "\n");
    finalMessage = finalMessage.replaceAll("\\n", "\n");
  }

}