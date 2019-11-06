import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class User extends ChangeNotifier{
  String title;
  String subtitle;
  IconData icon;
  String image;
  List<String> items;
  BuildContext context;
  Color menuColor;

  User({this.title,
    this.subtitle,
    this.icon,
    this.image,
    this.items,
    this.context,
    this.menuColor = Colors.black});



  change(String title){
    this.title = title;
  }

}