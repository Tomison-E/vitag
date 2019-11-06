import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vitag/View/Pages/raven.dart';
import 'package:vitag/View/Pages/Feed.dart';
import 'package:vitag/View/Pages/profile.dart';
import 'package:vitag/Utilities/Ui Data/uiData.dart';
import 'package:vitag/View/Pages/notfound/notfound_page.dart';
import 'package:vitag/View/Pages/movie_details_page.dart';
import 'package:vitag/Router/screenArguments/EventScreenArgument.dart';
import 'package:vitag/View/Pages/Live.dart';
import 'package:vitag/View/Pages/Home.dart';
import 'package:vitag/View/Pages/views.dart';
import 'package:vitag/Router/screenArguments/feedScreen.dart';


class Router {


    static Route<dynamic> generateRoute(settings) {
      switch (settings.name) {
        case UIData.homeRoute:
          return MaterialPageRoute(builder: (_) => Home());
          break;
        case UIData.view:
          return MaterialPageRoute(builder: (_) => ViewPage());
          break;
        case UIData.person:
          return MaterialPageRoute(builder: (_) => ProfilePage());
          break;
        case UIData.raven:
          return MaterialPageRoute(builder: (_) => RavenPage());
          break;
        case UIData.live:
          return MaterialPageRoute(builder: (_) => LivePage());
          break;
        case UIData.event:
          final EventScreenArguments args = settings.arguments;
          return MaterialPageRoute(builder: (_)=> MovieDetailsPage(args.event));
          break;
        case  UIData.feedRoute:
          final FeedScreenArguments args = settings.arguments;
          return MaterialPageRoute(builder: (_) => Feed(args.title));
      }
    }

    static Route<dynamic>  unknownRoute (settings) {
      return new MaterialPageRoute(
        builder: (context) => new NotFoundPage(
        ));
    }

}


/*  Navigator.pushNamed(
                  context,
                  PassArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Accept Arguments Screen',
                    'This message is extracted in the onGenerateRoute function.',
                  ),*/


/*final ScreenArguments args = ModalRoute.of(context).settings.arguments;*/

/*constructor*/


/*  bool value = await Navigator.of(context).push(new MaterialPageRoute<bool>(
    builder: (BuildContext context) {}));*/

/*Navigator.of(context).pop(true);*/