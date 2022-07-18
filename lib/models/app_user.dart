class AppUser {
  final String id;
  final String code;
  final String username;
  final String password;

  AppUser({required this.id, required this.code, required this.username, required this.password});

  static AppUser fromJson(Map<String, dynamic> json, String id){
    String code = json['code'];
    String username = json['username'];
    String password = json['password'];
    return AppUser(id: id, code: code, username: username, password: password);
  }

  String getId() {
    return id;
  }

}