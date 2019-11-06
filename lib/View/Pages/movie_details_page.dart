import 'package:flutter/material.dart';
import 'package:vitag/View/Widgets/actor_scroller.dart';
import 'package:vitag/Model/models.dart';
import 'package:vitag/View/Widgets/movie_detail_header.dart';
import 'package:vitag/View/Widgets/photo_scroller.dart';
import 'package:vitag/View/Widgets/story_line.dart';

class MovieDetailsPage extends StatelessWidget {
  MovieDetailsPage(this.movie);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieDetailHeader(movie),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Storyline(movie.storyline),
            ),
            PhotoScroller(movie.photoUrls),
            SizedBox(height: 30.0),
            ActorScroller(movie.actors),
          ],
        ),
      ),
    );
  }
}


