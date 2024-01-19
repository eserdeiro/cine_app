import 'package:cine_app/config/constants/typedefs.dart';
import 'package:cine_app/domain/datasources/movies_datasource.dart';
import 'package:cine_app/domain/repository/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource datasource;

  MovieRepositoryImpl({required this.datasource});

  @override
  FutureListItemEntity getNowPlaying({int page = 1}) =>
      datasource.getNowPlaying(page: page);

  @override
  FutureListItemEntity getPopular({int page = 1}) =>
      datasource.getPopular(page: page);

  @override
  FutureListItemEntity getUpcoming({int page = 1}) =>
      datasource.getUpcoming(page: page);

  @override
  FutureListItemEntity getTopRated({int page = 1}) =>
      datasource.getTopRated(page: page);

  @override
  FutureListItemEntity searchMoviesByQuery(String query) =>
      datasource.searchMoviesByQuery(query);

  @override
  FutureItemEntity getMovieById(String id) => 
      datasource.getMovieById(id);
}
