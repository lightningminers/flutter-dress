import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_dress/pages/home_page.dart';
import 'package:flutter_dress/shared/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        "/search": (_) => WebviewScaffold(
          url: "https://mijisou.com/",
          appBar: AppBar(
            title: Text(LeakzeroSearch),
            backgroundColor: DressThemeColor,
          ),
        ),
      },
    );
  }
}
