import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dress/bloc/BlocBase.dart';
import 'package:flutter_dress/bloc/BlocData.dart';
import 'package:flutter_dress/model/PhotoDir.dart';
import 'package:flutter_dress/shared/constants.dart';
import 'package:flutter_dress/utils/httpClient.dart';

const ActionInit = 'ActionInit';
const ActionToggle = 'ActionToggle';
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

  void _handleLogic(BlocData blocData){
    switch (blocData.action) {
      case ActionInit:
        _photoDirs = _removeTypeisDir(blocData.data);
        break;
      case ActionToggle:
        _photoDirs = _toggleIndex(blocData.params);
        break;
      default:
    }
    _inAdd.add(_photoDirs);
  }

  List<PhotoDir> _removeTypeisDir(List<PhotoDir> data){
    return data.where((v) => v.type == 'dir').toList();
  }

  List<PhotoDir> _toggleIndex(int params){
    final photoDir = _photoDirs.removeAt(params);
    final c = photoDir.collections;
    photoDir.collections = !c;
    _photoDirs.insert(0, photoDir);
    return _photoDirs;
  }

  void _getAsyncAuthors(){
    httpGet<List>(GithubPhotoDirsURL).then((response){
      if(response.status == NetworkOK){
        final photoDirs  = response.data.map<PhotoDir>((value){
          return PhotoDir.fromJSON(value);
        }).toList();
        _inputPhotoDirs.add(new BlocData(
          ActionInit,
          data: photoDirs,
        ));
      } else {
        // error
      }
    });
  }

  void toggleIndexCollections(int index){
    _inputPhotoDirs.add(new BlocData(
      ActionToggle,
      params: index
    ));
  }

  void dispose(){
    _outputController.close();
    _actionController.close();
  }
}
