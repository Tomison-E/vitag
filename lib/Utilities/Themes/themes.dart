import 'package:flutter/material.dart';

class Style{

  static ThemeData themes(){
    return ThemeData(
      primarySwatch: Colors.blueGrey,textTheme: TextTheme(display1: TextStyle(color: Colors.white),title: TextStyle(color:Colors.white)),
      //fontFamily: "CustomFont"
    );
  }

}

//unique theme

/*
Theme(
  // Create a unique theme with "ThemeData"
  data: ThemeData(
    accentColor: Colors.yellow,
  ),
  child: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
);
 */

//using a theme

/*
  color: Theme.of(context).accentColor,
 */

//extending theme

/*
Theme(
  // Find and Extend the parent theme using "copyWith". Please see the next
  // section for more info on `Theme.of`.
  data: Theme.of(context).copyWith(accentColor: Colors.yellow),
  child: FloatingActionButton(
    onPressed: null,
    child: Icon(Icons.add),
  ),
);
 */