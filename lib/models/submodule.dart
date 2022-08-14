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

}