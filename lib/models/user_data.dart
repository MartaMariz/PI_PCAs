class UserData {
  final String id;
  final String username;
  final String code;
  final int image;

  UserData({required this.id, required this.username, required this.code , required this.image});

  static UserData fromJson(Map<String, dynamic> json, String id) {
    String code = json['code'];
    String username = json['username'];
    int image = json['image'];

    print(code);
    return UserData(id: id, username: username, code: code, image: image);
  }

  @override
  String toString(){
    return "id: " + id + " - code: " + code + " - username: " + username;
  }
}