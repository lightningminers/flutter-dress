import 'package:flutter/material.dart';


final test = 'API rate limit exceeded for xxx.xxx.xxx.xxx. (But here\'s the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)';
class DressPhotosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        padding: EdgeInsets.all(10.0),
        child: _buildErrorMessage(),
      ),
    );
  }

  Widget _buildErrorMessage(){
    return new Row(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(
            right: 5.0
          ),
          child: new Icon(Icons.error_outline),
        ),
        new Expanded(
          flex: 1,
          child: new Text(
            test,
            style: new TextStyle(
              color: Colors.redAccent
            ),
          ),
        )
      ],
    );
  }
}