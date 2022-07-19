class AppUser {
  final String id;

  AppUser({required this.id});

  @override
  String toString(){
    return "id: " + id;
  }
}