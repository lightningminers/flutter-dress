import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

Future get(String url) async {
  try {
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    String data = await response.transform(utf8.decoder).join();
    var _data = jsonDecode(data);
    if(_data is Map && _data['message'] is String) {
      print(_data['message']);
      return null;
    } else {
      return _data;
    }
  } catch (e) {
    debugPrint(e.message);
  }
}