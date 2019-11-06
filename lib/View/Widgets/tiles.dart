import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  const Tiles({
    Key key,
    @required this.image,
    @required this.name,
    @required this.message,
  }) :assert(message!=null),
        super(key: key);

  final String image;

  final String name;

  final String message;



  @override
  Widget build(BuildContext context) {
  return Padding(
  child:
    Row(
    children: <Widget>[
      Column(
        children: <Widget>[
         Padding(child: CircleAvatar(backgroundImage: AssetImage(image),maxRadius: 15.0,),padding: EdgeInsets.only(left:15.0,right: 15.0))
        ],
      ),
 Column(
        children: <Widget>[
       Text(name,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0,),maxLines: 1,),
          Text(message,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 13.0),)
        ], crossAxisAlignment: CrossAxisAlignment.start,
      )]),
    padding: EdgeInsets.only(bottom: 10.0));
  }
}

