import 'package:cine_app/domain/datasources/local_database_datasource.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

//isarDatasource
class LocalDatabaseDataSourceImpl extends LocalDatabaseDatasource {
  LocalDatabaseDataSourceImpl() {
    database = openDB();
    Hive.registerAdapter(ItemEntityAdapter());
  }
  late Future<Box<ItemEntity>> database;

  Future<Box<ItemEntity>> openDB() async {
    //   final dir = await getApplicationCacheDirectory();
    //   Hive.initFlutter(dir.path);

    final box = await Hive.openBox<ItemEntity>('item_entity_box');
    return box;
  }

  //Check each item if it is favorite or not, by id
  @override
  Future<bool> isItemFavorite(int itemId) async {
    final box = await database;
    final isItemFavorite = box.values.where((item) {
      return item.id == itemId;
    }).toList(); // convert a list to use the isNotEmpty method...
    return isItemFavorite.isNotEmpty;
  }

  //Offset brings the items after x, example
  //If offset is 10, bring the items after the next 10
  @override
  Future<List<ItemEntity>> loadFavoriteItems({
    int limit = 9,
    int offset = 0,
  }) async {
    final box = await database;
    final items = box.values.skip(offset).take(limit).toList();
    return items;
  }

  //We save, update or delete when tap favorite icon
  @override
  Future<void> toggleFavorite(ItemEntity item) async {
    final box = await database;

    // Check if the item is already a favorite
    final favoriteItemIndex =
        box.values.toList().indexWhere((itemDb) => itemDb.id == item.id);

    if (favoriteItemIndex != -1) {
      await box
          .deleteAt(favoriteItemIndex); // Item is already a favorite, remove it
    } else {
      await box.add(item); // Item is not a favorite, add it
    }
  }
}
