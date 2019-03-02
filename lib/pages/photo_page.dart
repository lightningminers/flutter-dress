import 'package:flutter/material.dart';
import 'package:flutter_dress/shared/constants.dart';
import 'package:flutter_dress/model/Photo.dart';
import 'package:flutter_dress/widgets/ProgressWidget.dart';
import 'package:flutter_dress/utils/httpClient.dart';

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
    httpGet<List>(_url).then((response){
      if (response.status == NetworkOK) {
        final photos = response.data.map<Photo>((value){
          return Photo.fromJSON(value);
        }).toList();
        setState(() {
          _photos = photos;
        });
      } else {
        // error
      }
    });
  }
}
