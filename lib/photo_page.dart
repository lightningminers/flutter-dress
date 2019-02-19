import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_dress/shared/constants.dart';
import 'package:flutter_dress/model/Photo.dart';
import 'package:flutter_dress/model/ResponseData.dart';

class PhotoPage extends StatefulWidget {

  PhotoPage({Key key, this.url, this.dirName }) : super(key:key);

  final String url;
  final String dirName;

  @override
  PhotoPageState createState() => new PhotoPageState(
    url,
    dirName
  );
}

class PhotoPageState extends State<PhotoPage>{

  final String _url;
  final String _dirName;

  PhotoPageState(this._url, this._dirName) : super();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(_dirName),
          backgroundColor: DressThemeColor,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
        body: new Padding(
          padding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }

  void _getAsyncPhoto(){
    Future<Future<ResponseData<List<Photo>>>> doingFuture = new Future(_fetchPhoto);
    doingFuture.then((done){
      done.then((response){
        if (response.errorCode == NetworkOK) {

        } else {
          
        }
      });
    });
  }

  Future<ResponseData<List<Photo>>> _fetchPhoto() async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(_url));
    var response = await request.close();
    var body = await response.transform(utf8.decoder).join();
    var data = jsonDecode(body);
    if (data is List) {
      return new ResponseData(data.map<Photo>((value){
        return Photo.fromJSON(value);
      }).toList(), NetworkOK, '');
    } else {
      return new ResponseData([], NetworkFail, data['message']);
    }
  }
}