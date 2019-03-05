import 'package:flutter/material.dart';
import 'package:flutter_dress/model/PhotoDir.dart';
import 'package:flutter_dress/shared/constants.dart';


typedef void OnTapCollections(PhotoDir photoDir, int index);
class PhotoDirWidget extends StatelessWidget {

  PhotoDirWidget({Key key, this.index, this.photoDir, @required this.onChanged, @required this.onTapCollections}) : super(key: key);
  final int index;
  final PhotoDir photoDir;
  final Function onChanged;
  final OnTapCollections onTapCollections;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
        if (onChanged !=null) {
          onChanged();
        }
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
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.0
                      ),
                      child: Text(
                        photoDir.name
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.collections,
                      color: photoDir.collections? Colors.black87 : Colors.black26,
                    ),
                    onPressed: (){
                      if (onTapCollections !=null) {
                        onTapCollections(photoDir, index);
                      }
                    },
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
