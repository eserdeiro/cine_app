import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
    //If u want see more movies, you must modify the scale
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    if(nowPlayingMovies.isEmpty) return [];
      return nowPlayingMovies.sublist(0,20);

});