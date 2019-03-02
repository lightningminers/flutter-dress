import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_dress/model/ResponseData.dart';
import 'package:flutter_dress/shared/constants.dart';

Future<ResponseData<T>> httpGet<T>(String url) async {
  try {
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    String data = await response.transform(utf8.decoder).join();
    var _data = jsonDecode(data);
    if(_data is Map && _data['message'] is String) {
      debugPrint(_data['message']);
      return ResponseData(null, NetworkFail, _data['message']);
    } else {
      return ResponseData(_data, NetworkOK, "");
    }
  } catch (e) {
    debugPrint(e.message);
    return ResponseData(e, NetworkFail, e.message);
  }
}
