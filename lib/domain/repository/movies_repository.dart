import 'package:cine_app/config/constants/typedefs.dart';

abstract class MoviesRepository {

  FutureListItemEntity getNowPlaying({int page = 1});

  FutureListItemEntity getPopular({int page = 1});

  FutureListItemEntity getUpcoming({int page = 1});

  FutureListItemEntity getTopRated({int page = 1});

  FutureItemEntity getMovieById(String id);

  FutureListItemEntity searchMoviesByQuery(String query);
  
}
