import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'dart:async';


class Screen extends StatefulWidget {
  Screen ({this.title = 'Raven'});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ScreenState();
  }
}

class _ScreenState extends State<Screen> {
  TargetPlatform _platform = TargetPlatform.iOS;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(
        'https://quickloaded.com/wp-content/uploads/2019/06/Zlatan__This_Year_Quickloaded-com.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      fullScreenByDefault: false,
      isLive: true,
      allowedScreenSleep: false,
      //deviceOrientationsAfterFullScreen: [DeviceOrientation.landscapeRight,DeviceOrientation.landscapeLeft],
      // Try playing around with some of these other options:

      // showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
         handleColor: Colors.blue,
         backgroundColor: Colors.grey,
         bufferedColor: Colors.lightGreen,
       ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );

    _timer = new Timer(const Duration(seconds: 3), () {
      setState(() {
        _chewieController.enterFullScreen();
      });
    });



  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData.light().copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),backgroundColor: CupertinoColors.darkBackgroundGray,
        body: Column(
            children:[
              Padding(child:Hero(tag:"fly",child:CircleAvatar(backgroundImage: AssetImage("assets/images/falz.jpeg"),radius: 50.0)),padding: EdgeInsets.only(left: 15.0)),
         SizedBox(height: 30.0),
         Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
      ],
          crossAxisAlignment: CrossAxisAlignment.start,
        )
      ),
    );
  }
}