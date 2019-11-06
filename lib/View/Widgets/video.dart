import 'package:flutter/material.dart';


class Video extends StatelessWidget{
  String video;
Video({this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Text(video)
      ),
    );
  }


}

//video_player: ^0.10.0+4