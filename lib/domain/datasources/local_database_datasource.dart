import 'package:cine_app/domain/entities/movie_entity.dart';

abstract class LocalDatabaseDatasource {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMoviefavorite(int movieId);

  Future<List<Movie>> loadFavoriteMovies({int limit = 10, int offset = 0});
}
