import 'package:flutter/material.dart';
import 'package:flutter_dress/model/Issue.dart';
import 'package:flutter_dress/bloc/BlocProvider.dart';
import 'package:flutter_dress/bloc/IssuesBlocData.dart';
import 'package:flutter_dress/widgets/ProgressWidget.dart';
import 'package:flutter_dress/shared/constants.dart';
import 'package:intl/intl.dart';

class IssuesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<IssuesBlocData>(
      bloc: IssuesBlocData(),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Container(
            foregroundDecoration:
                BoxDecoration(border: Border.all(color: AuthorBorderColor)),
            child: MyTab()),
      ),
    );
  }
}

class MyTab extends StatefulWidget {
  @override
  MyTabState createState() => MyTabState();
}

class MyTabState extends State {
  int _activeIndex = 0;

  Widget _renderTab() {
    return TabBar(
      labelPadding: EdgeInsets.all(0.0),
      indicatorColor: Colors.transparent,
      onTap: (int index) {
        setState(() {
          _activeIndex = index;
        });
      },
      tabs: typeValue.map<Widget>((String value) {
        bool active = typeValue.indexOf(value) == _activeIndex;
        List colors = [Colors.white, DressThemeColor];
        if (active) {
          colors = colors.reversed.toList();
        }
        return Container(
          width: 300.0,
          color: colors[0],
          child: Tab(
            child: Text(
              value,
              style: TextStyle(color: colors[1]),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<IssuesBlocData>(context);
    bloc.getIssuesData(IssuesType.open);
    return StreamBuilder(
        stream: bloc.openIssuesStream,
        initialData: IssuesContainer(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Issue> openIssues = snapshot.data.openIssues;
          List<Issue> closedIssues = snapshot.data.closedIssues;
          return DefaultTabController(
              length: typeValue.length,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _renderTab(),
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

  List<Widget> _renderRowItem(Issue issue) {
    List<Widget> list = [];

    list.add(Expanded(
      child: Text(
        issue.title,
        overflow: TextOverflow.ellipsis,
      ),
    ));
    return list;
  }

  Widget _renderOtherInfo(Issue issue) {
    String time = DateFormat('y/M/d H:m').format(DateTime.parse(issue.createdAt));
    return Text(
      '#${issue.number} ${time} by ${issue.login}',
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (issues.length > 0) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: issues.map<Widget>((Issue value) {
            return Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                margin: EdgeInsets.symmetric(vertical: 5.0),
                foregroundDecoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(value.userAvatar),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            children: _renderRowItem(value),
                          ),
                          _renderOtherInfo(value)
                        ],
                      ),
                    )
                  ],
                ));
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
