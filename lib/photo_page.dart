import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_dress/shared/constants.dart';
import 'package:flutter_dress/model/Photo.dart';
import 'package:flutter_dress/model/ResponseData.dart';
import 'package:flutter_dress/widgets/ProgressWidget.dart';

class PhotoPage extends StatefulWidget {

  PhotoPage({Key key, this.url, this.dirName }) : super(key:key);

  final String url;
  final String dirName;

  @override
  _PhotoPageState createState() => new _PhotoPageState(
    url,
    dirName
  );
}

class _PhotoPageState extends State<PhotoPage>{

  final String _url;
  final String _dirName;
  List<Photo> _photos = [];

  _PhotoPageState(this._url, this._dirName) : super();

  @override
  void initState(){
    super.initState();
    debugPrint('initState _APhotoPageState');
    _getAsyncPhoto();
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
        body: new Center(
          child: new Padding(
            padding: EdgeInsets.all(10.0),
            child: _photos.length > 0 ? _buildItems(context) :  ProgressWidget(),
          )
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context){
    return new GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 4.0,
      children: _photos.map((photo){
        return _getGridViewItemUI(context, photo);
      }).toList(),
    );
  }

  Widget _getGridViewItemUI(BuildContext context, Photo photo) {
    return InkWell(
      onTap: () {
        
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          children: <Widget>[
            Image.network(
              photo.imageURL,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }

  void _getAsyncPhoto(){
    Future<Future<ResponseData<List<Photo>>>> doingFuture = new Future(_fetchPhoto);
    doingFuture.then((done){
      done.then((response){
        if (response.errorCode == NetworkOK) {
          setState(() {
            _photos = response.data;
          });
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