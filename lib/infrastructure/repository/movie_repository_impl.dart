import 'package:cine_app/domain/datasources/movies_datasource.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/domain/repository/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {

      final MoviesDataSource datasource;

  MovieRepositoryImpl({required this.datasource}); 

  @override
  Future<List<ItemEntity>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<ItemEntity>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }
  
   @override
  Future<List<ItemEntity>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }
  
  @override
  Future<List<ItemEntity>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }
  
  @override
  Future<ItemEntity> getMovieById(String id) {
    return datasource.getMovieById(id);
  }
  
  @override
  Future<List<ItemEntity>> searchMoviesByQuery(String query) {
    return datasource.searchMoviesByQuery(query);
  }

}