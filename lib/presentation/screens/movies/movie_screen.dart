import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {

  final String movieId;
  static const name = 'movie_screen';

  const MovieScreen({
    super.key, 
    required this.movieId});

  @override
  Widget build(BuildContext context) {

      //TODO SET VIDEOS, select first option[0]
      //https://api.themoviedb.org/3/movie/{IDMOVIE}/videos?api_key={API_KEY}&language=es-ARG

      //And this response 
      //"id": 670292,
      //"results": [
          //'type': 'Trailer'
          //'site': 'Youtube', 
          //'official': 'true', 
          //'key': 'oRTC5aFjXQw'(https://www.youtube.com/watch?v=oRTC5aFjXQw)
      //]
    return  Scaffold(
      appBar: AppBar(
        title: Text('MovieID $movieId'),
      ),
    );
  }
}