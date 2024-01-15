import 'package:cine_app/domain/entities/item_entity.dart';

typedef FutureListItemEntity = Future<List<ItemEntity>>;

abstract class MoviesDataSource {

  FutureListItemEntity getNowPlaying({int page = 1});

  FutureListItemEntity getPopular({int page = 1});
  
  FutureListItemEntity getUpcoming({int page = 1});

  FutureListItemEntity getTopRated({int page = 1});
  
  Future<ItemEntity> getMovieById(String id);

  FutureListItemEntity searchMoviesByQuery(String query);
  
}
