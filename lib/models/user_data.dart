class UserData {
  final String id;
  final String username;
  final String code;
  final int image;
  List<int> submodulesUnlocked = [0];

  UserData({required this.id, required this.username, required this.code, required this.image, required this.submodulesUnlocked});

  static UserData fromJson(Map<String, dynamic> json, String id) {
    String code = json['code'];
    String username = json['username'];
    int image = json['image'];
    List<int> submodulesUnlocked = json['submodules'].toList();

    return UserData(id: id, username: username, code: code, image: image, submodulesUnlocked: submodulesUnlocked);
  }

  @override
  String toString(){
    return "id: " + id + " - code: " + code + " - username: " + username + " - submodulesUnlocked: " + submodulesUnlocked.toString();
  }
}