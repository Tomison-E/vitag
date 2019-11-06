import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitag/Model/login.dart';
import 'package:vitag/View/Widgets/backdrop.dart';
import 'package:vitag/Utilities/Ui Data/uiData.dart';
import 'package:vitag/Router/screenArguments/EventScreenArgument.dart';
import 'package:vitag/Service/movie_api.dart';
import 'dart:math' as math;



// One BackdropPanel is visible at a time. It's stacked on top of the
// the BackdropDemo.
class BackdropPanel extends StatelessWidget {
  const BackdropPanel({
    Key key,
    this.onTap,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.title,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new Material(
      color: Theme.of(context).primaryColor,
      child:
           child,

    );
  }
}

// Cross fades between 'Select a Category' and 'Asset Viewer'.
class BackdropTitle extends AnimatedWidget {
  const BackdropTitle({
    Key key,
    Listenable listenable,
  }) : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: new Stack(
        children: <Widget>[
          new Opacity(
            opacity: new CurvedAnimation(
              parent: new ReverseAnimation(animation),
              curve: const Interval(0.5, 1.0),
            ).value,
            child: const Text('Select a Category'),
          ),
          new Opacity(
            opacity: new CurvedAnimation(
              parent: animation,
              curve: const Interval(0.5, 1.0),
            ).value,
            child: const Text('Asset Viewer'),
          ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  static const String routeName = '/material/backdrop';

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = new GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  Category _category = allCategories[0];


  @override
  void initState() {
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void _changeCategory(Category category) {
    setState(() {
      _category = category;
      _controller.fling(velocity: 2.0);
    });
  }

  bool get _backdropPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  void _toggleBackdropPanelVisibility() {
    _controller.fling(velocity: _backdropPanelVisible ? -2.0 : 2.0);
  }

  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  // By design: the panel can only be opened with a swipe. To close the panel
  // the user must either tap its heading or the backdrop's menu icon.

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed)
      return;

    _controller.value -= details.primaryDelta / (_backdropHeight ?? details.primaryDelta);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed)
      return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  // Stacks a BackdropPanel, which displays the selected category, on top
  // of the backdrop. The categories are displayed with ListTiles. Just one
  // can be selected at a time. This is a LayoutWidgetBuild function because
  // we need to know how big the BackdropPanel will be to set up its
  // animation.
  Widget _buildStack(BuildContext context, BoxConstraints constraints,) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    const double panelTitleHeight = 48.0;
    final Size panelSize = constraints.biggest;
    final double panelTop = panelSize.height - panelTitleHeight;

    final Animation<RelativeRect> panelAnimation = new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(
        0.0,
        panelTop - MediaQuery.of(context).padding.bottom,
        0.0,
        panelTop - panelSize.height,
      ),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(
      new CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    final ThemeData theme = Theme.of(context);
    final List<Widget> backdropItems = allCategories.map<Widget>((Category category) { // top view
      final bool selected = category == _category;
      return new Material(
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
        ),
        color:  Colors.transparent,
        child: new ListTile(
          title: new Text(category.title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          onTap: () {
            _changeCategory(category);
          },
        ),
      );
    }).toList();

    return new Container( // bottom view
      key: _backdropKey,
      color: theme.primaryColor,
      child: new Stack(
        children: <Widget>[
          new ListTileTheme(
            iconColor: theme.primaryIconTheme.color,
            textColor: theme.primaryTextTheme.title.color.withOpacity(0.6),
            selectedColor: theme.primaryTextTheme.title.color,
            child: new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: backdropItems,
              ),
            ),
          ),
          new PositionedTransition(
            rect: panelAnimation,
            child: new BackdropPanel(
              onTap: _toggleBackdropPanelVisibility,
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
                child: ListView(
                children: [
                GestureDetector(
                child:Column(
                children:[
               Expanded(child: Container( child:
                Card(color: Colors.white,elevation: 10.0, child: Image.asset('assets/images/poster.jpg',fit: BoxFit.cover,),),height:_height-250.0,width:_width-20.0,margin: EdgeInsets.all(10.0),)),
                Divider(color: Colors.black87, height: 10.0,),
                 Center(child:SizedBox(child: Row(
                   children:[
                     Icon(Icons.arrow_left),
                     Text("Swipe",style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic),),
                     Icon(Icons.arrow_right),
                   ],
                   mainAxisAlignment: MainAxisAlignment.center,
                 ),

                 ),),

                ],
              ),
                onTap: ()=> Navigator.pushNamed(
                  context,
                  UIData.event,
                  arguments: EventScreenArguments(
                      testMovie
                  ),)),
                  Column(
                    children:[
                    Expanded(child: Container( child:
                      Card(color: Colors.white,elevation: 10.0, child: Image.asset('assets/images/falz.jpeg',fit: BoxFit.cover,),),height:_height-250.0,width:_width-20.0,margin: EdgeInsets.all(10.0),)),
                      Divider(color: Colors.black87, height: 20.0,),
                      Center(child:SizedBox(child: Row(
                        children:[
                          Icon(Icons.arrow_left),
                          Text("Swipe",style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic),),
                          Icon(Icons.arrow_right),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )
                      ),)
                    ],
                  ),
                Column(
                  children:[
                    Expanded(child: Container( child:
                    Card(color: Colors.white,elevation: 10.0, child: Image.asset('assets/images/falz.jpeg',fit: BoxFit.cover,),),height:_height-250.0,width:_width-20.0,margin: EdgeInsets.all(10.0),)),
                    Divider(color: Colors.black87, height: 20.0,),
                    Center(child:SizedBox(child: Row(
                      children:[
                        Icon(Icons.arrow_left),
                        Text("Swipe",style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic),),
                        Icon(Icons.arrow_right),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                    ),)
                  ],
                ),
                Column(
                  children:[
                    Expanded(child: Container( child:
                    Card(color: Colors.white,elevation: 10.0, child: Image.asset('assets/images/wizkid.jpg',fit: BoxFit.cover,),),height:_height-250.0,width:_width-20.0,margin: EdgeInsets.all(10.0),)),
                    Divider(color: Colors.black87, height: 20.0,),
                    Center(child:SizedBox(child: Row(
                      children:[
                        Icon(Icons.arrow_left),
                        Text("Swipe",style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic),),
                        Icon(Icons.arrow_right),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                    ),)
                  ],
                ),
                Column(
                  children:[
                    Expanded(child: Container( child:
                    Card(color: Colors.white,elevation: 10.0, child: Image.asset('assets/images/wizkid2.png',fit: BoxFit.cover,),),height:_height-250.0,width:_width-20.0,margin: EdgeInsets.all(10.0),)),
                    Divider(color: Colors.black87, height: 20.0,),
                    Center(child:SizedBox(child: Row(
                      children:[
                        Icon(Icons.arrow_left),
                        Text("Swipe",style: TextStyle(fontWeight: FontWeight.normal,fontStyle: FontStyle.italic),),
                        Icon(Icons.arrow_right),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                    ),)
                  ],
                )
        ],scrollDirection: Axis.horizontal,)

            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BackdropDemo Bd = new BackdropDemo();
    final loginState = Provider.of<Login>(context);

    final double _width = MediaQuery.of(context).size.width;


    final double _height = MediaQuery.of(context).size.height;




    return new Container(
        decoration: new BoxDecoration(
        color: Colors.blueGrey,
        // image: DecorationImage(image: ExactAssetImage("assets/images/davido.jpg"),fit: BoxFit.cover,),
    ),
    child:
    new Scaffold(
    backgroundColor: Colors.transparent,
    appBar: new AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: new Text("RAVEN",style: TextStyle(color:Colors.black),),
    leading: IconButton(icon: Icon(Icons.person,color: Colors.black,), onPressed: ()=> Navigator.pushNamed(context, UIData.person)),
      actions: <Widget>[
        new IconButton(
          onPressed: _toggleBackdropPanelVisibility,
          icon: new AnimatedIcon(
            icon: AnimatedIcons.close_menu,color: Colors.black,
            progress: _controller.view,
          ),
        ),
      ],
    ),
      body: new LayoutBuilder(
        builder: _buildStack,
      ),
    )
    );
  }
}