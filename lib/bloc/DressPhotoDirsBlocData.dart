import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_dress/bloc/BlocBase.dart';
import 'package:flutter_dress/bloc/BlocData.dart';
import 'package:flutter_dress/model/PhotoDir.dart';
import 'package:flutter_dress/model/ResponseData.dart';
import 'package:flutter_dress/shared/constants.dart';

const ActionUpdate = 'ActionUpdate';
const ActionError = 'ActionError';

class DressPhotoDirsBlocData implements BlocBase {
  List<PhotoDir> _photoDirs = [];
  StreamController<List<PhotoDir>> _outputController = new StreamController();
  StreamSink<List<PhotoDir>> get _inAdd => _outputController.sink;
  Stream<List<PhotoDir>> get outPhotoDirs => _outputController.stream;
  StreamController<BlocData<List<PhotoDir>>> _actionController = new StreamController();
  StreamSink<BlocData<List<PhotoDir>>> get _inputPhotoDirs => _actionController.sink;

  DressPhotoDirsBlocData(){
    _getAsyncAuthors();
    _actionController.stream.listen(_handleLogic);
  }

  void _handleLogic(BlocData<List<PhotoDir>> blocData){
    switch (blocData.action) {
      case ActionUpdate:
        _photoDirs = blocData.data.where((v) => v.type == 'dir').toList();
        break;
      default:
    }
    _inAdd.add(_photoDirs);
  }

  void _getAsyncAuthors(){
    Future<ResponseData<List<PhotoDir>>> doingFuture = new Future(_fetchPhotoDirs);
    doingFuture.then((response){
      if (response.errorCode == NetworkOK) {
        _inputPhotoDirs.add(new BlocData(response.data, ActionUpdate));
      } else {
        
      }
    });
  }

  Future<ResponseData<List<PhotoDir>>> _fetchPhotoDirs() async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(GithubPhotoDirsURL));
    var response = await request.close();
    var body = await response.transform(utf8.decoder).join();
    var data = jsonDecode(body);
    if (data is List) {
      return new ResponseData(data.map<PhotoDir>((value){
        return PhotoDir.fromJSON(value);
      }).toList(), NetworkOK, '');
    } else {
      return new ResponseData([], NetworkFail, data['message']);
    }
  }

  void dispose(){
    _outputController.close();
    _actionController.close();
  }
}