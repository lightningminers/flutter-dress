import 'package:flutter/material.dart';
import 'package:flutter_dress/shared/constants.dart';
import 'package:flutter_dress/widgets/TabsWidget.dart';
import 'package:flutter_dress/widgets/ProgressWidget.dart';
import 'package:flutter_dress/widgets/AvatarCard.dart';
import 'package:flutter_dress/utils/httpClient.dart';
import 'package:flutter_dress/model/Author.dart';
import 'package:flutter_dress/model/PullRequest.dart';

class AppAuthorPage extends StatefulWidget {
  @override
  AppAuthorPageState createState() => AppAuthorPageState();
}

class AppAuthorPageState extends State {
  List<Author> _authors;
  List<PullRequest> _pullRequests;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget _renderAuthorCard(Author author) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(
            bottom: 10.0,
          ),
          child: new Text(
            author.login,
            style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
          ),
        ),
        new Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: new Text(
            author.githubUrl,
            style: new TextStyle(color: Colors.blue),
          ),
        ),
        new Text('提交 commits 总数：${author.contributions}')
      ],
    );
  }

  Widget _renderPRCard(PullRequest pullRequest) {
        return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(
            bottom: 10.0,
          ),
          child: new Text(
            pullRequest.login,
            style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
          ),
        ),
        new Text('贡献总数：${pullRequest.contributions}')
      ],
    );
  }

  Widget _renderList(bool isAuthor, data, Function renderFunction) {
    List<Widget> _children;
    if(data == null) {
      return ProgressWidget();
    }
    if(isAuthor) {
      _children = data.map<Widget>((Author value) {
              return AvatarCard(value.avatar, renderFunction(value));
            }).toList();
    } else {
      _children = data.map<Widget>((PullRequest value) {
              return AvatarCard(value.avatarUrl, renderFunction(value));
            }).toList();
    }
    return ListView(
      children: _children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      foregroundDecoration:
          BoxDecoration(border: Border.all(color: AuthorBorderColor)),
      child: TabsWidget(
        tabs: <String>['应用作者', '女装作者'],
        child: TabBarView(
          children: <Widget>[
            _renderList(true, _authors, _renderAuthorCard),
            _renderList(false, _pullRequests, _renderPRCard)
          ],
        ),
      ),
    );
  }

  void getData() {
    httpGet<List>(GithubContributorsURL).then((response) {
      if (response.status == NetworkOK) {
        final authors = response.data.map<Author>((value) {
          return Author.fromJSON(value);
        }).toList();
        setState(() {
          _authors = authors;
        });
      }
    });

    httpGet<List>(GithubDressPR).then((response) {
      if (response.status == NetworkOK) {
        final pullRequest = response.data.map((value) {
          return PullRequest.fromJSON(value);
        }).toList();

        setState(() {
          _pullRequests = pullRequest;
        });
      }
    });
  }
}
