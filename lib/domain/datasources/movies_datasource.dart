import 'package:cine_app/config/constants/typedefs.dart';
import 'package:cine_app/domain/entities/index.dart';

abstract class MoviesDataSource {

  FutureListItemEntity getNowPlaying({int page = 1});

  FutureListItemEntity getPopular({int page = 1});
  
  FutureListItemEntity getUpcoming({int page = 1});

  FutureListItemEntity getTopRated({int page = 1});
  
  Future<ItemEntity> getMovieById(String id);

  FutureListItemEntity searchMoviesByQuery(String query);
  
}
