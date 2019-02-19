import 'package:flutter/material.dart';
import 'package:flutter_dress/model/PhotoDir.dart';
import 'package:flutter_dress/shared/constants.dart';

class PhotoDirWidget extends StatelessWidget {
  
  PhotoDirWidget({Key key, this.photoDir, @required this.onChanged}) : super(key: key);

  final PhotoDir photoDir;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
        onChanged();
      },
      child: new Container(
        padding: EdgeInsets.only(
          bottom: 5.0
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
          child: new Row(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(
                  right: 5.0
                ),
                child: new Icon(
                  Icons.cloud_circle
                ),
              ),
              new Text(
                photoDir.name
              ),
            ],
          ),
        ),
      ),
    );
  }
}