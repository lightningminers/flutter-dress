import 'package:flutter/material.dart';

class IssuesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Container(
          foregroundDecoration:
              BoxDecoration(border: Border.all(color: Colors.black12)),
          child: MyTab()),
    );
  }
}

class MyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                children: <Widget>[Text('data'), Text('sd')],
              ),
            )
          ],
        ));
  }
}
