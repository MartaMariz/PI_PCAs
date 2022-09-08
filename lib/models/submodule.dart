import 'package:flutter/material.dart';

class SubModule {
  String name;
  String description;
  List<String>? content;
  String? exercise;
  bool locked;
  bool hasExercise;
  bool hasContent;
  bool hasTextBox;
  bool hasAudio;
  int id;
  bool done;
  Map<int, String>? images;

  SubModule({
    required this.name,
    required this.description,
    this.locked = true,
    required this.hasExercise,
    required this.hasContent,
    required this.id,
    this.done = false,
    this.hasTextBox = false,
    this.hasAudio = false});

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
          var separated = content![i].split("[");
          content![i] = separated[0];
          images ??= {};
          images![i] = separated[1].split("]")[0];
        }
      }
    }
  }

  void checkAudioOrTextBox(){
    if (exercise != null){
      if (exercise!.contains("Exercício experiencial – ")){
        var separated = exercise!.split("Exercício experiencial – ");
        exercise = separated[1];
        hasAudio = true;
      }
      else if (exercise!.contains("Exercício de resposta – ")){
        var separated = exercise!.split("Exercício de resposta – ");
        exercise = separated[1];
        hasTextBox = true;
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

  void addExercise(Map<String, dynamic> json) {
    exercise = json['exercise'];
    exercise = exercise!.replaceAll("\\n", "\n");
  }
}