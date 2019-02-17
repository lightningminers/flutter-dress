import 'package:flutter/material.dart';
import 'package:flutter_dress/shared/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('女装大佬'),
        backgroundColor: DressThemeColor
      ),
    );
  }
}