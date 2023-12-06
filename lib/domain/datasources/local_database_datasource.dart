import 'package:cine_app/domain/entities/item_entity.dart';

abstract class LocalDatabaseDatasource {
  Future<void> toggleFavorite(ItemEntity item);

  Future<bool> isItemFavorite(int itemId);

  Future<List<ItemEntity>> loadFavoriteItems({int limit = 9, int offset = 0});
}
