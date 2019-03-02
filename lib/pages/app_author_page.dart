import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_dress/model/Author.dart';
import 'package:flutter_dress/shared/constants.dart';
import 'package:flutter_dress/widgets/ProgressWidget.dart';
import 'package:flutter_dress/utils/httpClient.dart';

class AppAuthorPage extends StatefulWidget {
  AppAuthorPage({Key key}) : super(key: key);

  @override
  _AppAuthorPageState createState() => new _AppAuthorPageState();
}

class _AppAuthorPageState extends State<AppAuthorPage> {

  List<Author> _authors = [];
  int _errorCode = NetworkOK;
  String _errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('initState _AppAuthorPageState');
    _getAsyncAuthors();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build _AppAuthorPageState');
    return new Center(
      child: _buildAll(),
    );
  }

  Widget _buildAll(){
    if(_errorCode == NetworkOK){
      if(_authors.length > 0){
        return _buildItems();
      } else {
        return new ProgressWidget();
      }
    } else {
      return _buildErrorItems();
    }
  }

  Widget _buildErrorItems(){
    return new Padding(
      padding: EdgeInsets.all(10),
      child: new Row(
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
              _errorMessage,
              style: new TextStyle(
                color: Colors.redAccent
              ),
            )
          ),
        ],
      )
    );
  }

  Widget _buildItems(){
    return ListView.builder(
      itemCount: _authors.length,
      itemBuilder: (BuildContext context, int index){
        final author = _authors[index];
        return new Container(
          padding: EdgeInsets.all(10.0),
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
                    right: 10.0
                  ),
                  child: new Container(
                    width: 100,
                    height: 100,
                    child: new ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      child: new Image.network(
                        author.avatar,
                        fit: BoxFit.cover,
                      ),
                    )
                  )
                ),
                new Container(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: new Text(
                          author.login,
                          style: new TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.only(
                          bottom: 5.0
                        ),
                        child: new Text(
                          author.githubUrl,
                          style: new TextStyle(
                            color: Colors.blue
                          ),
                        ),
                      ),
                      new Text('提交 commits 总数：${author.contributions}')
                    ],
                  )
                )
              ],
            )
          )
        );
      },
    );
  }

  void _getAsyncAuthors(){
    httpGet<List>(GithubContributorsURL).then((response){
      if (response.status == NetworkOK) {
        final authors = response.data.map<Author>((value){
          return Author.fromJSON(value);
        }).toList();
        setState(() {
          _authors = authors;
          _errorCode = response.status;
          _errorMessage = '';
        });
      } else {
        setState(() {
          _errorCode = response.status;
          _errorMessage = response.errorMessage;
        });
      }
    });
  }
}
