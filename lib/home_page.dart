import 'package:flutter/material.dart';
import 'package:flutter_dress/shared/constants.dart';
import 'package:flutter_dress/app_author_page.dart';
import 'package:flutter_dress/dress_photos_page.dart';

class HomePage extends StatefulWidget{

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _selectedTitle = DressPhotoText;
  final _widgetOptions = [
    DressPhotosPage(),
    AppAuthorPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_selectedTitle),
        backgroundColor: DressThemeColor,
      ),
      body: new Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new Icon(Icons.photo),
            title: new Text(DressPhotoText),
            backgroundColor: DressThemeColor
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.supervisor_account),
            title: new Text(AppAuthorText),
            backgroundColor: DressThemeColor
          )
        ],
        currentIndex: _selectedIndex,
        fixedColor: DressThemeColor,
        onTap: _onSelectItemWidget,
      ),
    );
  }

  void _onSelectItemWidget(int index){
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 1:
          _selectedTitle = AppAuthorText;
          break;
        default:
          _selectedTitle = DressPhotoText;
          break;
      }
    });
  }
}