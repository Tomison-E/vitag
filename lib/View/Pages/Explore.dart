import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vitag/Model/data.dart';
import 'package:flutter/rendering.dart';
import 'package:vitag/Utilities/Ui Data/uiData.dart';



class ExplorePage extends StatelessWidget {
  ExplorePage();


  @override
  Widget build(BuildContext context) {
    //final loginState = Provider.of<Login>(context);

    final double _width = MediaQuery
        .of(context)
        .size
        .width;
    final double _height = MediaQuery
        .of(context)
        .size
        .height;

    createTile(Book book) =>
        Hero(
          tag: book.title,
          child:
          Material(
            elevation: 15.0,
            shadowColor: Colors.yellow.shade900,
            child: InkWell(
              onTap: () {
              Navigator.pushNamed(context, UIData.view);
              },
              child:Image(
                image: AssetImage(book.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        //  Container( child:Text("Tomsisin",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),alignment: Alignment.bottomLeft, decoration: BoxDecoration(d),)

        );

    ///create book grid tiles
    final grid = CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverGrid.count(
            childAspectRatio: 2/3 ,
            crossAxisCount: 2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: books.map((book) => createTile(book)).toList(),
          ),
        )
      ],
    );


    return new Container(
        decoration: new BoxDecoration(
          color: CupertinoColors.lightBackgroundGray,
          // image: DecorationImage(image: ExactAssetImage("assets/images/davido.jpg"),fit: BoxFit.cover,),
        ),
        child:
        new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: new TextField(textInputAction: TextInputAction.search,
              decoration: InputDecoration(labelText: "search"),),
            leading: IconButton(icon: Icon(Icons.person, color: Colors.black,),
                onPressed: () {}),
          ),
          body:  grid,

        )
    );
  }



}