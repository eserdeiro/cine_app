import 'package:cine_app/config/constants/typedefs.dart';
import 'package:cine_app/domain/entities/item_entity.dart';

abstract class LocalDatabaseRepository {
  Future<void> toggleFavorite(ItemEntity item);

  Future<bool> isItemFavorite(int itemId);

  FutureListItemEntity loadFavoriteItems({int limit = 9, int offset = 0});
}
