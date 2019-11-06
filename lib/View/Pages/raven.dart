import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:vitag/Utilities/Ui Data/uiData.dart';
import 'package:vitag/Router/screenArguments/feedScreen.dart';



class RavenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RavenState();
  }
}

class RavenState extends State<RavenPage> {
  /// create a channelController to retrieve text value


  /// if channel textfield is validated to have error
  bool _firstStateEnabled = true;
  Timer _timer;


  @override
  void dispose() {
    // dispose input controller
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _timer = new Timer(const Duration(seconds: 1), () {
      setState(() {
      _firstStateEnabled = false;
      });
    });


  }





  @override
  Widget build(BuildContext context) {

    final double _width = MediaQuery.of(context).size.width;

    final double _height = MediaQuery.of(context).size.height;



    Widget first = Container(
      color: Colors.white,
      height: _height,
    );


    Widget second =  GestureDetector(
      child:Container(
      color: Colors.transparent,
     // decoration: BoxDecoration(image:DecorationImage(image:AssetImage("assets/images/VR.jpg"),fit: BoxFit.fitHeight)),
      child: Stack(
          children:[
           Align(child:Container(child: Card(child: Image.asset("assets/images/VR copy.jpg",height: 400.0,width: _width,fit: BoxFit.fitHeight,),elevation: 0.0),height: 300.0,),alignment: Alignment.center,),
        /*    SizedBox(
              width: _width,
              child: TyperAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                text: [
                  "R",
                  "A",
                  "V",
                  "E",
                  "N",
                  "RAVEN"
                ],
                textStyle: TextStyle(
                  fontSize: 30.0,
                  fontFamily: "CustomFont",
                  color: Colors.grey
                ),
                duration: Duration(seconds: 30),
                textAlign: TextAlign.center,
                alignment: AlignmentDirectional.bottomCenter,
                // or Alignment.topLeft
              ),
            ),*/
         PageView(
                children:[
                  Stack(
                  children:[Positioned(child: Hero(tag: "fly", child:CircleAvatar(backgroundImage: AssetImage("assets/images/falz.jpeg"),radius:  _width/5.76923077)),right: _width/13.3928571-7, top: _height/2.55345912),
                  Positioned(child: CircleAvatar(backgroundImage: AssetImage("assets/images/falz.jpeg"),radius:_width/5.76923077),left: _width/13.3928571-7, top: _height/2.55345912)
    ]),
    Stack(
    children:[Positioned(child: CircleAvatar(backgroundImage: AssetImage("assets/images/poster.jpg"),radius: _width/5.76923077),right: _width/13.3928571-7,top:  _height/2.55345912,),
    Positioned(child: CircleAvatar(backgroundImage: AssetImage("assets/images/poster.jpg"),radius: _width/5.76923077),left: _width/13.3928571-7, top:  _height/2.55345912)
    ]),
                  Stack(
                      children:[Positioned(child: CircleAvatar(backgroundImage: AssetImage("assets/images/wizkid.jpg"),radius: _width/5.76923077),right: _width/13.3928571-7, top:  _height/2.55345912),
                      Positioned(child: CircleAvatar(backgroundImage: AssetImage("assets/images/wizkid.jpg"),radius: _width/5.76923077),left: _width/13.3928571-7, top:  _height/2.55345912)
                      ]), //_height/2.7066667

                ],
            ),
          ]
      ),
      alignment: Alignment.center,
      height: _height,
      ),
      onDoubleTap: ()=>Navigator.pushNamed(
          context,
          UIData.feedRoute,
          arguments: FeedScreenArguments("test") ),

    );

    return new Container(
        decoration: new BoxDecoration(
          color: CupertinoColors.white,
          // image: DecorationImage(image: ExactAssetImage("assets/images/davido.jpg"),fit: BoxFit.cover,),
        ),
        child:  new Scaffold(
                    backgroundColor: Colors.transparent,
            appBar: PreferredSize(
    child:new AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: new IconButton(icon:Image.asset("assets/images/raven.png"),color: Colors.grey,onPressed: ()=> Navigator.pushNamed(
    context,
    UIData.feedRoute,
    arguments: FeedScreenArguments("test") ,)),
              leading: IconButton(icon: Icon(CupertinoIcons.back,color: Colors.black), onPressed: (){Navigator.pop(context);} ),
              actions: <Widget>[
                new IconButton(
                  onPressed: (){},
                  icon: new Icon(
                    CupertinoIcons.fullscreen_exit,color: Colors.black,
                  ),
                ),
              ],
            ),
              preferredSize: Size.fromHeight(50.0),
            ),

                    body: AnimatedCrossFade(firstChild: first, secondChild: second, crossFadeState: _firstStateEnabled
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond, duration: Duration(seconds: 1),alignment: Alignment.center,firstCurve: Curves.easeIn,secondCurve: Curves.easeIn,)
        )
    );
  }
}
