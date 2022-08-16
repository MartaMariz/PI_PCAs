import 'package:flutter/material.dart';

class SubModule {
  String name;
  String description;
  List<String>? content;
  String? exercise;
  bool favorite;
  bool locked;
  bool hasExercise;
  bool hasContent;
  int id;
  bool done;
  Map<int, String>? images;

  SubModule({
    required this.name,
    required this.description,
    this.locked = true,
    this.favorite = false,
    required this.hasExercise,
    required this.hasContent,
    required this.id,
    this.done = false});

  static SubModule fromJson(Map<String, dynamic> json) => SubModule(
    name: json['name'],
    description: json['description'],
    hasExercise: json['hasExercise'],
    hasContent: json['hasContent'],
    id: json['id']
  );

  void checkNewlines(){
    description = description.replaceAll("\\n", "\n");
  }

  void checkImages(){
    if (content != null){
      for (int i = 0; i<content!.length; i++){
        if (content![i].contains("[")){
          //RegExp exp = RegExp(r'^[[a-zA-Z0-9]+]$');
          var splitted = content![i].split("[");
          content![i] = splitted[0];
          images ??= {};
          images![i] = splitted[1].split("]")[0];
          print("imagename :" + images![i]!);
        }
      }
    }
  }

  void addContent(Map<String, dynamic> json) {
    content ??= [];
    for (String i in json['content']) {
      content!.add(i);
    }
    content = content!.map((e) => e.replaceAll("\\n", "\n")).toList();
  }
}