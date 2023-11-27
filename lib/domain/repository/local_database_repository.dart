import 'package:cine_app/domain/entities/movie_entity.dart';

abstract class LocalDatabaseRepository {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMoviefavorite(int movieId);

  Future<List<Movie>> loadFavoriteMovies({int limit = 9, int offset = 0});
}
