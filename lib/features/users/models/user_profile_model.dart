class UserProfileModel {
  final String uid;
  final String nick;
  final String email;
  final String name;
  final String bio;
  final String link;
  final String birthday;

  UserProfileModel({
    required this.uid,
    required this.nick,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
    required this.birthday,
  });

  UserProfileModel.empty()
      : uid = "",
        nick = "",
        email = "",
        name = "",
        bio = "",
        link = "",
        birthday = "";

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        nick = json["nick"],
        email = json["email"],
        name = json["name"],
        bio = json["bio"],
        link = json["link"],
        birthday = json["birthday"];

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "nick": nick,
      "email": email,
      "name": name,
      "bio": bio,
      "link": link,
      "birthday": birthday,
    };
  }
}
