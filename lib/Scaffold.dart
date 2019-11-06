import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vitag/View/Pages/Home.dart';
import 'package:vitag/View/Pages/Explore.dart';
import 'package:vitag/View/Pages/settings.dart';
import 'package:vitag/Utilities/Ui Data/uiData.dart';

class Scaffolds extends StatefulWidget {
  @override
  _ScaffoldsState createState() => new _ScaffoldsState();
}

class _ScaffoldsState extends State<Scaffolds> {
  int _curIndex = 1;
  Color color = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _curIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: color,
          elevation: 0.0,
//          iconSize: 22.0,
          onTap: (index) {
            _curIndex = index;
            setState(() {
              if(index == 1){
                color=Colors.blueGrey;
              }
              else{
                color=CupertinoColors.lightBackgroundGray;
              }
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: IconButton(icon:Icon(Icons.tv,color: _curIndex == 0 ? Colors.black : Colors.grey),onPressed: ()=>Navigator.pushNamed(context, UIData.raven)),
              title: Text(
                "",
              ),
              backgroundColor: Colors.transparent
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: _curIndex == 1 ? Colors.black : CupertinoColors.inactiveGray),
              title: Text(
                "",
              ),
                backgroundColor: Colors.teal
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore,color: _curIndex == 2 ? Colors.black : Colors.grey),
              title: Text(
                "",
              ),
                backgroundColor: Colors.transparent
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,color: _curIndex == 3 ? Colors.black : Colors.grey ),
              title: Text(
                "",
              ),
                backgroundColor: Colors.white
            ),

          ]),
      body: new Center(
        child: _getWidget(context),
      ),
    );
  }

  Widget _getWidget(BuildContext context) {
    switch (_curIndex) {
      case 0:
        return Text("lol");
        break;
      case 1:
        return Container(
          child: Home(),
        );
        break;
      case 2:
        return Container(
          child: ExplorePage(),
        );
        break;
      default:
        return Container(
          child:Settings(),
        );
        break;
    }
  }
}