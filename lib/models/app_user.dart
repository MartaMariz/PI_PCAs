class AppUser {
  late final String id;
  final String code;
  final String username;
  final String password;

  AppUser({required this.id, required this.code, required this.username, required this.password});
  AppUser.withoutId(this.code, this.username, this.password);


  static AppUser fromJson(Map<String, dynamic> json, String id){
    String code = json['code'];
    String username = json['username'];
    String password = json['password'];
    return AppUser(id: id, code: code, username: username, password: password);
  }

  String getId() {
    return id;
  }

  setId (String id){
    this.id = id;
  }

  @override
  String toString(){
    return "id: " + id + " - code: " + code + " - username: " + username + " - password: " + password;
  }

}