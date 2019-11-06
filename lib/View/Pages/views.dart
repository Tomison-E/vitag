import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:vitag/Model/videosession.dart';
import 'package:vitag/View/Widgets/tiles.dart';
import 'package:vitag/Utilities/Ui Data/uiData.dart';

class ViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ViewState();
  }
}

class ViewState extends State<ViewPage> {

  final _channelName = "falz";
  static final _sessions = List<VideoSession>();
  final _infoStrings = <String>[];
  bool muted = false;



  @override
  void dispose() {
    // clean up native views & destroy sdk
    _sessions.forEach((session) {
      AgoraRtcEngine.removeNativeView(session.viewId);
    });
    _sessions.clear();
    AgoraRtcEngine.leaveChannel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
  }

  void initialize() {
    if (UIData.APP_ID.isEmpty) {
      setState(() {
        _infoStrings
            .add("APP_ID missing, please provide your APP_ID in settings.dart");
        _infoStrings.add("Agora Engine is not starting");
      });
      return;
    }

    _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    // use _addRenderView everytime a native video view is needed
    _addRenderView(0, (viewId) {
      AgoraRtcEngine.setupRemoteVideo(viewId, VideoRenderMode.Fit,0);
      AgoraRtcEngine.startPreview();
      // state can access widget directly
      AgoraRtcEngine.joinChannel(null, _channelName, null, 1);
    });
  }

  /// Create agora sdk instance and initialze
  Future<void> _initAgoraRtcEngine() async {
  AgoraRtcEngine.create(UIData.APP_ID);
  AgoraRtcEngine.enableVideo();
  AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
  AgoraRtcEngine.setClientRole(ClientRole.Audience);
  AgoraRtcEngine.enableWebSdkInteroperability(true);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
  AgoraRtcEngine.onError = (int code) {
  setState(() {
  String info = 'onError: ' + code.toString();
  _infoStrings.add(info);
  });
  };

  AgoraRtcEngine.onJoinChannelSuccess =
  (String channel, int uid, int elapsed) {
  setState(() {
  String info = 'onJoinChannel: ' + channel + ', uid: ' + uid.toString();
  _infoStrings.add(info);
  });
  };

  AgoraRtcEngine.onLeaveChannel = () {
  setState(() {
  _infoStrings.add('onLeaveChannel');
  });
  };

  AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
  setState(() {
  String info = 'userJoined: ' + uid.toString();
  _infoStrings.add(info);
  _addRenderView(uid, (viewId) {
  AgoraRtcEngine.setupRemoteVideo(viewId, VideoRenderMode.Hidden, uid);
  });
  });
  };

  AgoraRtcEngine.onUserOffline = (int uid, int reason) {
  setState(() {
  String info = 'userOffline: ' + uid.toString();
  _infoStrings.add(info);
  _removeRenderView(uid);
  });
  };

  AgoraRtcEngine.onFirstRemoteVideoFrame =
  (int uid, int width, int height, int elapsed) {
  setState(() {
  String info = 'firstRemoteVideo: ' +
  uid.toString() +
  ' ' +
  width.toString() +
  'x' +
  height.toString();
  _infoStrings.add(info);
  });
  };
  }

  /// Create a native view and add a new video session object
  /// The native viewId can be used to set up local/remote view
  void _addRenderView(int uid, Function(int viewId) finished) {
  Widget view = AgoraRtcEngine.createNativeView(uid, (viewId) {
  setState(() {
  _getVideoSession(uid).viewId = viewId;
  if (finished != null) {
  finished(viewId);
  }
  });
  });
  VideoSession session = VideoSession(uid, view);
  _sessions.add(session);
  }

  /// Remove a native view and remove an existing video session object
  void _removeRenderView(int uid) {
  VideoSession session = _getVideoSession(uid);
  if (session != null) {
  _sessions.remove(session);
  }
  AgoraRtcEngine.removeNativeView(session.viewId);
  }

  /// Helper function to filter video session with uid
  VideoSession _getVideoSession(int uid) {
  return _sessions.firstWhere((session) {
  return session.uid == uid;
  });
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
  return _sessions.map((session) => session.view).toList();
  }

  /// Video view wrapper  // \\ view for one look
  Widget _videoView(view) {
  return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper \\ more than one user
  Widget _expandedVideoRow(List<Widget> views) {
  List<Widget> wrappedViews =
  views.map((Widget view) => _videoView(view)).toList();
  return Expanded(
  child: Row(
  children: wrappedViews,
  ));
  }

  /// Video layout wrapper
  Widget _viewRows() {
  List<Widget> views = _getRenderViews();
  switch (views.length) {
  case 1:
  return Container(
  child: Column(
  children: <Widget>[_videoView(views[0])],
  ));
  case 2:
  return Container(
  child: Column(
  children: <Widget>[
  _expandedVideoRow([views[0]]),
  _expandedVideoRow([views[1]])
  ],
  ));
  case 3:
  return Container(
  child: Column(
  children: <Widget>[
  _expandedVideoRow(views.sublist(0, 2)),
  _expandedVideoRow(views.sublist(2, 3))
  ],
  ));
  case 4:
  return Container(
  child: Column(
  children: <Widget>[
  _expandedVideoRow(views.sublist(0, 2)),
  _expandedVideoRow(views.sublist(2, 4))
  ],
  ));
  default:
  }
  return Container();
  }


  @override
  Widget build(BuildContext context) {
  final double _width = MediaQuery.of(context).size.width;

  final double _height = MediaQuery.of(context).size.height;
  List<Widget> views = _getRenderViews();

  return new Container(
  decoration: new BoxDecoration(
  color: Colors.transparent,
  // image: DecorationImage(image: ExactAssetImage("assets/images/davido.jpg"),fit: BoxFit.cover,),
  ),
  child: Stack(
  children: <Widget>[
  Container(
  child: views[0],
  height: _height,
  ),
  SafeArea(
  child: new Scaffold(
  backgroundColor: Colors.transparent,
  appBar: new AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0.0,
  title: new ActionChip(
  label: Text("Live",style: TextStyle(fontWeight: FontWeight.bold),),
  onPressed: () {},
  labelStyle: TextStyle(
  color: Colors.white,
  ),
  backgroundColor: Colors.redAccent,
  ),
  leading: new IconButton(
  icon: Container( child:new Icon(Icons.stop,color: Colors.redAccent,size: 35.0,),decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),),
  onPressed: () {
  Navigator.of(context).pop();
  },
  ),
  actions: <Widget>[
  ],
  ),
  body: Align(
  child: SingleChildScrollView(
  child: Column(
  children: <Widget>[
  Tiles(image: "assets/images/1.png", name: "Kennedy4u" , message: "I am on my way homie"),
  Tiles(image: "assets/images/2.png", name: "lomie", message: "I cant believe mans missing this"),
  Tiles(image: "assets/images/3.png", name: "Kennedy4u" , message: "I am on my way homie"),
  Tiles(image: "assets/images/4.png", name: "lomie", message: "I cant believe mans missing this"),
  Container(
  margin: EdgeInsets.only(left:15.0,top: 10.0,bottom: 20.0),
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(20.0),
  border: Border.all(color: Colors.white70)),
  height: 40.0,
  width: 350.0,
  child: Padding(
  child: Text("Comment",
  style: TextStyle(
  color: Colors.white, fontSize: 15.0)),
  padding: EdgeInsets.all(10.0)),
  alignment: Alignment.bottomLeft,

  )
  ],
  crossAxisAlignment: CrossAxisAlignment.start,
  )),
  alignment: Alignment.bottomLeft)))
  ],
  ));
  }
}
