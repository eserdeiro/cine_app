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

import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:cine_app/presentation/providers/movies/movie_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  final String movieId;
  static const name = 'movie_screen';

  const MovieScreen({super.key, required this.movieId});

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
    if (movie == null)
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 3)));

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie: movie),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding:
                const EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //PosterPath
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:
                      Image.network(movie.posterPath, width: size.width * 0.3),
                ),
                const SizedBox(width: 10),
                //Overview
                SizedBox(
                    width: (size.width - 40) * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(movie.overview)],
                    )),
              ],
            )),
              //Genres
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Wrap(
                      children: [
                        ...movie.genreIds.map((e) => Container(
                              margin: const EdgeInsets.only(right: 8),
                              //TODO GESTURE DETECTOR, to movies related
                              child: Chip(
                                label: Text(e),
                              ),
                            ))
                      ],
                    )),
      ]);
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar.medium(
      expandedHeight: size.height * 0.2,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
        ),
        titlePadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        background: Stack(children: [
          SizedBox.expand(
            child: Image.network(movie.backdropPath, fit: BoxFit.cover),
          ),
          const SizedBox.expand(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.50, 1.0],
                        colors: [Colors.transparent, Colors.black54]))),
          ),
          const SizedBox.expand(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        stops: [0.0, 0.2],
                        colors: [Colors.black54, Colors.transparent]))),
          ),
        ]),
      ),
    );
  }
}
