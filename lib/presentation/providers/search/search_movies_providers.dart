import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:cine_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMoviesQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {

final movieRepository= ref.read(movieRepositoryProvider);
 
  return SearchedMoviesNotifier(
    searchMovies: movieRepository.searchMoviesByQuery, 
    ref: ref);
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {

  final SearchMoviesCallback searchMovies;
  final Ref ref;
  SearchedMoviesNotifier({
    required this.searchMovies,
    required this.ref
  }): super([]);
  
  Future<List<Movie>> searchMoviesByQuery(String query) async{
      final List<Movie> movies = await searchMovies(query);
      ref.read(searchMoviesQueryProvider.notifier).update((state) => query);
        state = movies;
      return movies;
  } 

}