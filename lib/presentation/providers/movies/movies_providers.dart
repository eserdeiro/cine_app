

import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//NowPlaying 
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<ItemEntity>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});

//Popular
final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<ItemEntity>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});

//Upcoming
final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<ItemEntity>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});

//TopRated
final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<ItemEntity>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});

typedef MovieCallback = Future<List<ItemEntity>> Function({int page});

class MoviesNotifier extends StateNotifier<List<ItemEntity>>{

  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
    }) : super([]);
  
  Future<void> loadNextPage() async {
    if(isLoading)return;

    isLoading = true;
    currentPage++;
    final movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
