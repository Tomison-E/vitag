import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';







class ProfilePage extends StatelessWidget {
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {

    final double _width = MediaQuery.of(context).size.width;

    final double _height = MediaQuery.of(context).size.height;

    return new Container(
        decoration: new BoxDecoration(
          color: CupertinoColors.darkBackgroundGray,
          image: DecorationImage(image: AssetImage("assets/images/1.png"),repeat: ImageRepeat.repeat)
        ),
        child:
        new Scaffold(
            backgroundColor: Colors.transparent,
            appBar: new AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.close, size: 26.0,),
                  onPressed: () {},
                ),
              ],
            ),
            body:Align(alignment:Alignment.bottomCenter,child:Container(alignment: Alignment.bottomCenter,height: 250.0,width: _width,color: Colors.transparent,
            child:Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(padding:EdgeInsets.only(left:10.0),child:Column( children:[ Text("155",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),), Text("Posts",style: TextStyle(color: Colors.white))])),
                   Align(alignment:Alignment.center,child:Column( children:[ Text("20k",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0)), Text("Followers",style: TextStyle(color: Colors.white))])),
                   Padding(padding:EdgeInsets.only(right:10.0),child:Column( children:[ Text("100",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0)), Text("Following",style: TextStyle(color: Colors.white))])),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
               SizedBox(height: 10.0),
              Expanded(
                  child:Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: CupertinoColors.white),
                  height: 179.0,
                  width: _width,
                  alignment: Alignment.bottomCenter,
                  child: Column(
                children:[  Row(
                    children: <Widget>[
                      Padding(padding:EdgeInsets.only(left: 15.0) ,child:Column(
                          children:[ Padding(padding: EdgeInsets.only(top:15.0),child:Text("Freddie Luv",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),textAlign: TextAlign.left,)), Text("Videographer",style: TextStyle(color: Colors.black,fontSize: 20.0),textAlign: TextAlign.left,)]
                      )),
                      Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20.0),border: Border.all(color:Colors.red)),child: Padding(padding:EdgeInsets.all(5.0),child:Text("Preview",style: TextStyle(color: Colors.red))),margin: EdgeInsets.only(right: 10.0),)
                    ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  Expanded(child:Align(alignment:Alignment.bottomCenter,child:
                   Padding(padding: EdgeInsets.only(bottom: 30.0,left:30.0,right: 30.0), child: Row(
                      children: <Widget>[
                        Icon(Icons.video_call,color: Colors.grey),
                        Icon(Icons.search,color: Colors.grey),
                        Container(decoration: BoxDecoration(color:Colors.red,shape: BoxShape.circle),child: Icon(Icons.add,color: Colors.white)),
                        Icon(Icons.image,color: Colors.grey),
                         Icon(Icons.personal_video,color: Colors.grey)
                      ],
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ))))
          ])
                )
               )
              ],
            )
            )),

        )
    );

  }




}

