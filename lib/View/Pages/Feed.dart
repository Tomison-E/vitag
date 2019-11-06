
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vitag/View/Widgets/screen.dart';
import 'package:vitag/Utilities/Themes/themes.dart';

class Feed extends StatelessWidget {

  final String data;

  Feed(this.data);
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
        child:
        Screen(title: "Raven"),
    )
    );
  }
}

