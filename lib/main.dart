import 'package:flutter/material.dart';
import 'package:vitag/Router/router.dart';
import 'package:vitag/Utilities/Ui Data/uiData.dart';
import 'package:vitag/Utilities/Themes/themes.dart';
import 'package:provider/provider.dart';
import 'package:vitag/Model/login.dart';
import 'package:vitag/Scaffold.dart';

void main() => runApp(
 new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: UIData.appName,
      theme: Style.themes(),
      onGenerateRoute: Router.generateRoute,
      //initialRoute: UIData.homeRoute,
      onUnknownRoute: Router.unknownRoute,
      home: ChangeNotifierProvider<Login>(
    builder: (context) => Login(),
    child:
      new Scaffolds(),));
  }
}

