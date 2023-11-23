import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:cine_app/presentation/providers/movies/movie_details_provider.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {

  final String movieId;
  static const name = 'movie_screen';

  const MovieScreen({
    super.key, 
    required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
  
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();
     ref.read(movieDetailProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {

     final Movie? movie = ref.watch(movieDetailProvider)[widget.movieId];

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
        title: Text('MovieID ${widget.movieId}'),
      ),
      body: _MovieScreenView(movie: movie),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class _MovieScreenView extends StatelessWidget {
  final Movie? movie;

  const _MovieScreenView({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
     if(movie != null )  return const Center(child: CircularProgressIndicator(strokeWidth: 3));
    return Placeholder();
  }
}