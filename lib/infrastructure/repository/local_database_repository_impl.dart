import 'package:cine_app/domain/datasources/local_database_datasource.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/domain/repository/local_database_repository.dart';

class LocalDatabaseRepositoryImpl extends LocalDatabaseRepository{

  final LocalDatabaseDatasource datasource;

  LocalDatabaseRepositoryImpl(this.datasource);

  @override
  Future<bool> isItemFavorite(int itemId) {
    return datasource.isItemFavorite(itemId);
  }

  @override
  Future<List<ItemEntity>> loadFavoriteItems({int limit = 9, int offset = 0}) {
    return datasource.loadFavoriteItems(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(ItemEntity item) {
   return datasource.toggleFavorite(item);
  }

}
