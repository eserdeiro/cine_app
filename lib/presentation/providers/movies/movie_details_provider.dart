import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailProvider = StateNotifierProvider<MovieMapNotifier,Map<String, ItemEntity>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider).getMovieById;

  return MovieMapNotifier(getMovieDetail: movieRepository);
});

typedef GetMovieCallback = Future<ItemEntity>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, ItemEntity>>{

  final GetMovieCallback getMovieDetail;
//  Maps each movie and maintains the cache in memory 
  MovieMapNotifier({
      required this.getMovieDetail
      }) : super({});

  Future<void> loadMovie(String movieId) async{
    if(state[movieId] != null ) return;
    final movie = await getMovieDetail( movieId );
    state = {...state, movieId : movie};
  }

}