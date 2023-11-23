import 'package:cine_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}