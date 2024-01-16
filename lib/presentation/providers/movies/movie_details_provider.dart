import 'package:cine_app/config/constants/typedefs.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/providers/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailProvider = StateNotifierProvider<MovieMapNotifier, Map<String, ItemEntity>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider).getMovieById;

  return MovieMapNotifier(getMovieDetail: movieRepository);
});

typedef GetMovieCallback = FutureItemEntity Function(String movieId);

class MovieMapNotifier extends LoadNotifier<ItemEntity> {
  MovieMapNotifier({
    required GetMovieCallback getMovieDetail,
  }) : super(getItem: getMovieDetail);
}
