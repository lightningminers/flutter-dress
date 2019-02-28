import 'package:flutter/material.dart';
import 'package:flutter_dress/model/Issue.dart';
import 'package:flutter_dress/bloc/BlocProvider.dart';
import 'package:flutter_dress/bloc/IssuesBlocData.dart';
import 'package:flutter_dress/widgets/ProgressWidget.dart';

class IssuesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<IssuesBlocData>(
      bloc: IssuesBlocData(),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Container(
            foregroundDecoration:
                BoxDecoration(border: Border.all(color: Colors.black12)),
            child: MyTab()),
      ),
    );
  }
}

class MyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<IssuesBlocData>(context);
    return StreamBuilder(
        stream: bloc.openIssuesStream,
        initialData: IssuesContainer(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Issue> openIssues = snapshot.data.openIssues;
          List<Issue> closedIssues = snapshot.data.closedIssues;
          return DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TabBar(
                    labelColor: Colors.blue,
                    tabs: <Widget>[
                      Tab(
                        text: 'open',
                      ),
                      Tab(
                        text: 'closed',
                      )
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        IssuesView(
                          issues: openIssues,
                        ),
                        IssuesView(
                          issues: closedIssues,
                        )
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}

class IssuesView extends StatelessWidget {
  final List<Issue> issues;

  IssuesView({@required this.issues});

  @override
  Widget build(BuildContext context) {
    if (issues.length > 0) {
      return Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: issues.map<Widget>((Issue value) {
            return Container(
              height: 50,
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(bottom: 2.0),
              foregroundDecoration: BoxDecoration(
                border: Border.all(color: Colors.black12)
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(value.title, overflow: TextOverflow.ellipsis,),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      );
    } else {
      return Center(
        child: ProgressWidget(),
      );
    }
  }
}
