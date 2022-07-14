import 'submodule.dart';

class Module {
  String name;
  List<SubModule> submodules;
  bool locked;

  Module({
    required this.name,
    required this.submodules,
    this.locked = true
  });

  static Module fromJson(Map<String, dynamic> json) => Module(
        name: json['name'],
        submodules: [],
        locked: true
      );

}