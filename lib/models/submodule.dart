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

  SubModule({required this.name, required this.description, this.locked = true,
      required this.favorite, required this.hasExercise, required this.hasContent,
      required this.id, this.done = false});


}