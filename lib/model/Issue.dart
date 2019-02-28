class Issue {
  String title;

  Issue.fromJSON(Map<String, dynamic> json)
    : title = json['title'];
}
