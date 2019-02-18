class Author {
  final String login;
  final String avatar;
  final String githubUrl;
  final int contributions;

  Author(this.login, this.avatar, this.githubUrl, this.contributions);

  Author.fromJSON(Map<String, dynamic> json)
    : login = json['login'],
    avatar = json['avatar_url'],
    githubUrl = json['html_url'],
    contributions = json['contributions'];
}