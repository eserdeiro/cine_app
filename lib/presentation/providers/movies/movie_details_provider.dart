import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailProvider = StateNotifierProvider((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider).getMovieById;

  return MovieDetailsMapNotifier(getMovieDetail: movieRepository);
});

typedef GetMovieCallback = Future<Movie>Function(String movieId);

class MovieDetailsMapNotifier extends StateNotifier<Map<String, Movie>>{

  final GetMovieCallback getMovieDetail;

  MovieDetailsMapNotifier({
      required this.getMovieDetail
      }) : super({});

  Future<void> loadMovie(String movieId) async{
    if(state[movieId] != null ) return;
    final movie = await getMovieDetail( movieId );
    state = {...state, movieId : movie};
  }

}