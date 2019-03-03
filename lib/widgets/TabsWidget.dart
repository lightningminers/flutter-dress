import 'package:flutter/material.dart';
import 'package:flutter_dress/shared/constants.dart';

class TabsWidget extends StatefulWidget {
  final Widget child;
  final activeIndex;
  final List<String> tabs;
  final List<Widget> customTabs;
  final ValueChanged onTap;

  TabsWidget({
    Key key,
    this.child,
    this.activeIndex,
    this.tabs,
    this.customTabs,
    this.onTap,
  }) : super(key:key);

  @override
  TabsWidgetState createState() => new TabsWidgetState();
}

class TabsWidgetState extends State<TabsWidget> {

  int _activeIndex = 0;

  Widget _renderCustomTabs(){
    return Text('Todo');
  }

  Widget _renderTabs(){
    return TabBar(
      indicatorColor: Colors.transparent,
      onTap: (int index){
        setState(() {
          _activeIndex = index;
        });
        if (widget.onTap != null) {
          widget.onTap(index);
        }
      },
      tabs: widget.tabs.map<Widget>((String tabValue){
        bool active = widget.tabs.indexOf(tabValue) == _activeIndex;
        List colors = [Colors.white, DressThemeColor];
        if (active) {
          colors = colors.reversed.toList();
        }
        return Container(
          width: 300.0,
          color: colors[0],
          child: Tab(
            child: Text(
              tabValue,
              style: TextStyle(color: colors[1]),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _renderTabs(),
          Expanded(
            child: widget.child,
          )
        ],
      ),
    );
  }
}
