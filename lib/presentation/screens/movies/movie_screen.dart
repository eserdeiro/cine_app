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

     if(movie == null )  return const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 3)));

    return  Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),

        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      expandedHeight: size.height * 0.2 ,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
          ),
          titlePadding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          background: Stack(
            children: [
              SizedBox.expand(
                child: Image.network(
                  movie.backdropPath, 
                  fit: BoxFit.cover),
              )
            ]),
      ),
    ) ;
  }
}