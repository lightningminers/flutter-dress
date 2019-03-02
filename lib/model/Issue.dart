class Issue {
  String title;
  String userAvatar;

  Issue.fromJSON(Map<String, dynamic> json)
    : title = json['title'],
    userAvatar = json['user']['avatar_url'];
}
