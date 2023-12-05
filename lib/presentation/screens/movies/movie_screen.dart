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
import 'package:cine_app/config/helpers/formats.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';
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
    //final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //PosterPath
             const Text('Overview', style: TextStyle(
              fontFamily: 'Montserrat', 
              fontWeight: FontWeight.w600,
              fontSize: 20)),
              const SizedBox(width: 10),
            //Overview
            Text(movie.overview, style: const TextStyle(
              fontFamily: 'Montserrat', 
              fontWeight: FontWeight.w400,
            ))
          ],
        ),
          //Cast view
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('Cast', style: TextStyle(
                    fontFamily: 'Montserrat', 
                    fontWeight: FontWeight.w600,
                    fontSize: 20)),
          ),
    
        _ActorsByMovie(movieId: movie.id.toString()),
        const SizedBox(height: 50)
      ]),
    );
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
      height: 65,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //Actor photo
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(actor.profilePath,
                      height: 50, width: 50, fit: BoxFit.cover),
                ),

                //Name
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(actor.name,
                       style: const TextStyle(
                        fontFamily: 'Montserrat', 
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                      //Actor character
                      Text(actor.character ?? '',
                          maxLines: 2,
                           style: const TextStyle(
                            fontFamily: 'Montserrat', 
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
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
    final titleStyle = Theme.of(context).textTheme;
    return SliverAppBar(
      centerTitle: true,
      title: Text(movie.title),
      expandedHeight: size.height * 0.6,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async{
            await ref.read(favoriteMoviesProvider.notifier)
            .toggleFavorite(movie);
            
            ref.invalidate(isFavoriteProvider(movie.id));
          }, icon: isFavoriteFutureProvider.when(
            data:(isFavorite){
              return isFavorite 
            ? const Icon(Icons.favorite_border_outlined, color: Colors.red) 
            : const Icon(Icons.favorite_border_outlined);
            } , 
            error: (e, __) => throw UnimplementedError(e.toString()), 
            loading: () => SpinPerfect(child: const Icon(Icons.refresh_outlined))))
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        background: Stack(
          children: [
            //Background posterpath
          SizedBox.expand(
            child: Image.network(movie.posterPath, 
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if(loadingProgress != null) return const SizedBox();
              return FadeIn(child: child);
            }),
          ),
         // Gradients
        const _CustomGradient(
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter, 
            stops: [0.5, 1.0],
            colors: [Colors.transparent, Color(0xff1f1d2b)]),

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
            
            //Center posterpah
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SizedBox(height: 100),
                  
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox.fromSize(
                      child: Image.network(movie.posterPath, height: 300,
                          //fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress != null) return const SizedBox();
                        return FadeIn(child: child);
                      }),
                    ),
                  ),

                  const SizedBox(height: 20),
                //Age
                 if (movie.releaseDate?.year != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month),
                      Text('${movie.releaseDate!.year}'),
                    ],
                  ),

                 //Genres
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.local_movies_rounded),
                  ...movie.genreIds.map((genreIds) {
                    return Text("$genreIds ");
                  }),
                  ],
                 ),

                 const SizedBox(height: 20),
                //Vote average 
                 SizedBox(
                   width: 50,
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 5),
                     child: Row(
                       children: [
                         const Icon(Icons.star, color: Color(0xfffd8701), size: 15),
                         const SizedBox(width: 2),
                         Text(Formats.number(movie.voteAverage , 1),
                             style: titleStyle.bodyMedium
                                 ?.copyWith(color: const Color(0xfffd8701))),
                         const Spacer(),
                       ],
                     ),
                   ), 
                 )
                ],
              ),
            ),
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
