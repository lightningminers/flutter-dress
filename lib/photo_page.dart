import 'package:flutter/material.dart';
import 'package:flutter_dress/shared/constants.dart';

class PhotoPage extends StatelessWidget {

  PhotoPage({Key key, this.url, this.dirName }) : super(key:key);

  final String url;
  final String dirName;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(dirName),
          backgroundColor: DressThemeColor,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
        body: new Text(url),
      ),
    );
  }
}