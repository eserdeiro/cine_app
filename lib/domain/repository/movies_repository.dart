import 'package:cine_app/domain/entities/item_entity.dart';

abstract class MoviesRepository {

  Future<List<ItemEntity>> getNowPlaying({int page = 1});

  Future<List<ItemEntity>> getPopular({int page = 1});

  Future<List<ItemEntity>> getUpcoming({int page = 1});

  Future<List<ItemEntity>> getTopRated({int page = 1});

  Future<ItemEntity> getMovieById(String id);

  Future<List<ItemEntity>> searchMoviesByQuery(String query);
  
}
