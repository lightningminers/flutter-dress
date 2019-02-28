class Issue {
  String title;
  String user_avatar;

  Issue.fromJSON(Map<String, dynamic> json)
    : title = json['title'],
    user_avatar = json['user']['avatar_url'];
}
