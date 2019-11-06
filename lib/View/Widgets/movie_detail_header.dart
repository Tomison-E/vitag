import 'package:flutter/material.dart';
import 'package:vitag/View/Widgets/arc_banner_image.dart';
import 'package:vitag/Model/models.dart';
import 'package:vitag/View/Widgets/poster.dart';
import 'package:vitag/Utilities/Ui Data/uiData.dart';
import 'package:permission_handler/permission_handler.dart';


class MovieDetailHeader extends StatelessWidget {
  MovieDetailHeader(this.movie);
  final Movie movie;

  List<Widget> _buildCategoryChips(TextTheme textTheme) {
    return movie.categories.map((category) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(category),
          labelStyle: textTheme.caption,
          backgroundColor: Colors.black12,
        ),
      );
    }).toList();
  }

  Widget actions(BuildContext context)=>
    Row(
      children: <Widget>[
        IconButton(icon: Image.asset("assets/images/raven.png"), onPressed: (){Navigator.pushNamed(context, UIData.raven);},iconSize: 50.0,),
        SizedBox(width:15.0),
        IconButton(icon: Image.asset("assets/images/live.png"), onPressed: (){
          onJoin(context);
        },iconSize: 50.0,),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );


  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    Widget movieInformation(BuildContext context)=> Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: TextStyle(color: Colors.black,fontSize: 18.0,fontFamily: "CustomFont")
        ),
        SizedBox(height:20.0),
        actions(context),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 140.0),
          child: ArcBannerImage(movie.bannerUrl),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Poster(
                movie.posterUrl,
                height: 180.0,
              ),
              SizedBox(width: 16.0),
              Expanded(child: movieInformation(context)),
            ],
          ),
        ),
      ],
    );
  }

  onJoin(BuildContext context) async {
    // update input validation
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      Navigator.pushNamed(context, UIData.live);;

  }

  _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
        [PermissionGroup.camera, PermissionGroup.microphone]);
  }
}
