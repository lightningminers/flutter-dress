class PullRequest {
  String avatarUrl;
  String login;
  num contributions;

  PullRequest.fromJSON(Map<String, dynamic> json)
    :avatarUrl = json['avatar_url'],
    login = json['login'],
    contributions = json['contributions'];

}
