import 'dart:async';
import 'package:flutter_dress/bloc/BlocBase.dart';
import 'package:flutter_dress/utils/httpClient.dart';
import 'package:flutter_dress/shared/constants.dart';
import 'package:flutter_dress/model/Issue.dart';

class IssuesContainer {
  List<Issue> openIssues = [];
  List<Issue> closedIssues = [];

}

enum IssuesType {
  open,
  closed
}

List<String> typeValue = ['open', 'closed'];

class IssuesBlocData implements BlocBase {
  //Dart 会把下划线开头的属性隐藏起来
  StreamController<IssuesContainer> openIssuesControl = StreamController();
  Stream get openIssuesStream => openIssuesControl.stream;

  getIssuesData(IssuesType type) {
    get('${GithubIssuesURL}?state=${typeValue[type.index]}').then((data) {
      if(data != null) {
        IssuesContainer typeData = IssuesContainer();

        List<Issue> _formatData = data.map<Issue>((value) {
          return Issue.fromJSON(value);
        }).toList();

        switch (type) {
          case IssuesType.open:
            typeData.openIssues = _formatData;
            break;
          default:
            typeData.closedIssues = _formatData;
        }
        openIssuesControl.sink.add(typeData);
      }
    });
  }

  void dispose() {
    openIssuesControl.close();
  }
}
