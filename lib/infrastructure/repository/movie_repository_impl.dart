import 'package:cine_app/domain/datasources/movies_datasource.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:cine_app/domain/repository/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {

      final MoviesDataSource datasource;

  MovieRepositoryImpl({required this.datasource}); 

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }
  
   @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }
}