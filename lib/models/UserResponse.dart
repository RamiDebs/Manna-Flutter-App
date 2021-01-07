class User {
  bool isVipMember;
  String token;
  String userEmail;
  String userNicename;
  String userDisplayName;

  User({this.token, this.userEmail, this.userNicename, this.userDisplayName});

  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userEmail = json['user_email'];
    userNicename = json['user_nicename'];
    userDisplayName = json['user_display_name'];
  }
}
