import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:cine_app/presentation/delegates/search_movie_delegate.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context,ref ) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text(Strings.appName, style: titleStyle),
              const Spacer(),
              IconButton(onPressed: (){

                final searchedMovies= ref.read(searchedMoviesProvider);
                final searchQuery = ref.read(searchMoviesQueryProvider);
                 showSearch<Movie?>(
                          query: searchQuery,
                          context: context,
                          delegate: SearchMovieDelegate(
                          initialMovies: searchedMovies,
                          searchMovies:  ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery))
                          .then((movie){
                            if(movie != null){
                              //redirect from '/movie' to '/home/0/move/id' because movie is not recognized
                              context.push('${Strings.movieRoute}${movie.id}');
                            }
                          });
              }, icon: const Icon(Icons.search))
      
            ],
          ),
        )),
    );
  }
}