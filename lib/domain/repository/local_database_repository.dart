import 'package:cine_app/domain/entities/item_entity.dart';

typedef FutureListItemEntity = Future<List<ItemEntity>>;

abstract class LocalDatabaseRepository {
  Future<void> toggleFavorite(ItemEntity item);

  Future<bool> isItemFavorite(int itemId);

  FutureListItemEntity loadFavoriteItems({int limit = 9, int offset = 0});
}
