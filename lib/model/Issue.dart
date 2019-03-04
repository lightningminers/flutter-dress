class Issue {
  String title;
  String userAvatar;
  num number;
  String createdAt;
  String updatedAt;
  // 用户名
  String login;

  Issue.fromJSON(Map<String, dynamic> json)
    : title = json['title'],
    number = json['number'],
    createdAt = json['created_at'],
    updatedAt = json['updated_at'],
    login = json['user']['login'],
    userAvatar = json['user']['avatar_url'];
}
