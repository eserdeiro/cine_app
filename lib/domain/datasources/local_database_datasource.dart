import 'package:cine_app/config/constants/typedefs.dart';
import 'package:cine_app/domain/entities/index.dart';

abstract class LocalDatabaseDatasource {
  Future<void> toggleFavorite(ItemEntity item);

  Future<bool> isItemFavorite(int itemId);

  FutureListItemEntity loadFavoriteItems({int limit = 9, int offset = 0});
}
