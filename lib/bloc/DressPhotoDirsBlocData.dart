import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_dress/bloc/BlocBase.dart';
import 'package:flutter_dress/bloc/BlocData.dart';
import 'package:flutter_dress/model/PhotoDir.dart';
import 'package:flutter_dress/shared/constants.dart';
import 'package:flutter_dress/utils/httpClient.dart';

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
    httpGet<List>(GithubPhotoDirsURL).then((response){
      if(response.status == NetworkOK){
        final photoDirs  = response.data.map<PhotoDir>((value){
          return PhotoDir.fromJSON(value);
        }).toList();
        _inputPhotoDirs.add(new BlocData(photoDirs, ActionUpdate));
      } else {
        // error
      }
    });
  }

  void dispose(){
    _outputController.close();
    _actionController.close();
  }
}
