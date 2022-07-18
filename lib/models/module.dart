import 'submodule.dart';

class Module {
  String name;
  List<SubModule> submodules;
  bool locked;
  String description;

  Module({
    required this.name,
    required this.description,
    required this.submodules,
    this.locked = true
  });

  static Module fromJson(Map<String, dynamic> json) => Module(
        name: json['name'],
        description: json['description'],
        submodules: json['submodels'],
        locked: true
      );

}