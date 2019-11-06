import 'package:vitag/Model/models.dart';

final Movie testMovie = Movie(
  bannerUrl: 'assets/images/banner.png',
  posterUrl: 'assets/images/poster.jpg',
  title: 'Davido Live In Concert',
  rating: 8.0,
  starRating: 4,
  categories: ['Concert', 'Entertainment'],
  storyline: 'It is the 3rd Concert of superstar rock nation DMW star artiste Davido at the Eko Atlantic Muson Center.',
  photoUrls: [
    'assets/images/wizkid.jpg',
    'assets/images/wizkid2.png',
    'assets/images/3.png',
    'assets/images/4.png',
  ],
  actors: [
    Actor(
      name: 'Clarence.',
      avatarUrl: 'assets/images/4.png',
    ),
    Actor(
      name: 'Dremo',
      avatarUrl: 'assets/images/1.png',
    ),
    Actor(
      name: 'Twitch',
      avatarUrl: 'assets/images/2.png',
    ),
    Actor(
      name: 'David',
      avatarUrl: 'assets/images/3.png',
    ),
    Actor(
      name: 'Ellie Kemper',
      avatarUrl: 'assets/images/ellie.png',
    ),
  ],
);
