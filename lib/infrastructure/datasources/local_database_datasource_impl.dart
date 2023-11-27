import 'package:cine_app/domain/datasources/local_database_datasource.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';
//isarDatasource
class LocalDatabaseDataSourceImpl extends LocalDatabaseDatasource{
  @override
  Future<bool> isMoviefavorite(int movieId) {
    // TODO: implement isMoviefavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({int limit = 10, int offset = 0}) {
    // TODO: implement loadFavoriteMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }

}