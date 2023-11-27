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

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:cine_app/presentation/providers/movies/movie_details_provider.dart';
import 'package:cine_app/presentation/providers/providers.dart';

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
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieDetailProvider)[widget.movieId];
    if (movie == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 3)));
    }

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

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //PosterPath
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath, width: size.width * 0.3),
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
      //Actors view
      _ActorsByMovie(movieId: movie.id.toString()),
      const SizedBox(height: 50)
    ]);
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    // if has no data, show circularprogress
    if (actorsByMovie[movieId] == null) {
      return const SizedBox(
          height: 270,
          child: Center(child: CircularProgressIndicator(strokeWidth: 3)));
    }

    final actors = actorsByMovie[movieId]!;
    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            width: 150,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Actor photo
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(actor.profilePath,
                      height: 180, width: 120, fit: BoxFit.cover),
                ),
                //Name
                const SizedBox(height: 5),
                Text(actor.name, maxLines: 2),
                const SizedBox(height: 5),
                //Actor character
                Text(actor.character ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold))
                //
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context,ref) {
    final isFavoriteFutureProvider = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;
    return SliverAppBar.medium(
      expandedHeight: size.height * 0.26,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async{
            await ref.watch(localDatabaseProvider)
            .toggleFavorite(movie);
            // await Future.delayed(const Duration(milliseconds: 100));
            ref.invalidate(isFavoriteProvider(movie.id));
          }, icon: isFavoriteFutureProvider.when(
            data:(isFavorite){
              return isFavorite 
            ? const Icon(Icons.favorite_border_outlined, color: Colors.red) 
            : const Icon(Icons.favorite_border_outlined);
            } , 
            error: (error, stackTrace) => throw UnimplementedError(error.toString()), 
            loading: () => SpinPerfect(child: const Icon(Icons.refresh_outlined))))
        //Icon(Icons.favorite_border_outlined, colors: Colors.red)
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
        ),
        titlePadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        background: Stack(children: [
          SizedBox.expand(
            child: Image.network(movie.backdropPath, 
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if(loadingProgress != null) return const SizedBox();
              return FadeIn(child: child);
            }),
          ),
          //Gradients
        const _CustomGradient(
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter, 
            stops: [0.5, 1.0],
            colors: [Colors.transparent, Colors.black54]),

          const _CustomGradient(
            begin: Alignment.topLeft, 
            end: Alignment.bottomRight, 
            stops: [0.0, 0.5],
            colors: [Colors.black87, Colors.transparent]),

          const _CustomGradient(
            begin: Alignment.topRight, 
            end: Alignment.bottomLeft, 
            stops: [0.0, 0.5],
            colors: [Colors.black87, Colors.transparent]),
        ]),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final Alignment begin;
  final Alignment end;
  final List<double> stops;
  final List<Color> colors;
  const _CustomGradient({
    required this.begin,
    required this.end,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, 
                  end: end, 
                  stops: stops, 
                  colors: colors))),
    );
  }
}
