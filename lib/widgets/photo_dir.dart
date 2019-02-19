import 'package:flutter/material.dart';
import 'package:flutter_dress/model/PhotoDir.dart';
import 'package:flutter_dress/shared/constants.dart';

class PhotoDirWidget extends StatelessWidget {
  
  PhotoDirWidget({Key key, this.photoDir, @required this.onChanged}) : super(key: key);

  final PhotoDir photoDir;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(
        bottom: 10.0
      ),
      child: new Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: AuthorBorderColor,
            width: 2.0,
            style: BorderStyle.solid
          )
        ),
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Text(
                photoDir.name
              ),
            )
          ],
        ),
      ),
    );
  }
}