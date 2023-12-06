import 'package:cine_app/domain/datasources/local_database_datasource.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/domain/repository/local_database_repository.dart';

class LocalDatabaseRepositoryImpl extends LocalDatabaseRepository{

  final LocalDatabaseDatasource datasource;

  LocalDatabaseRepositoryImpl(this.datasource);

  @override
  Future<bool> isMoviefavorite(int movieId) {
    return datasource.isMoviefavorite(movieId);
  }

  @override
  Future<List<ItemEntity>> loadFavoriteMovies({int limit = 9, int offset = 0}) {
    return datasource.loadFavoriteMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(ItemEntity movie) {
   return datasource.toggleFavorite(movie);
  }

}