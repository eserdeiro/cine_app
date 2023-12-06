import 'package:cine_app/domain/entities/item_entity.dart';

abstract class LocalDatabaseRepository {
  Future<void> toggleFavorite(ItemEntity movie);

  Future<bool> isMoviefavorite(int movieId);

  Future<List<ItemEntity>> loadFavoriteMovies({int limit = 9, int offset = 0});
}
