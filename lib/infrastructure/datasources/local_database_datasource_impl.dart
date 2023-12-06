import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cine_app/domain/datasources/local_database_datasource.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
//isarDatasource
class LocalDatabaseDataSourceImpl extends LocalDatabaseDatasource{

  late Future<Isar> database;

  LocalDatabaseDataSourceImpl(){
    database = openDB();
  }

  Future<Isar> openDB() async{
    final dir = await getApplicationCacheDirectory();
    if(Isar.instanceNames.isEmpty){
      return await Isar.open([ItemEntitySchema], directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  //Check each movie if it is favorite or not, by id
  @override
  Future<bool> isMoviefavorite(int movieId) async{
    
    final isar = await database;
    final ItemEntity? isItemFavorite = await isar.itemEntitys
    .filter()
    .idEqualTo(movieId)
    .findFirst();

    return isItemFavorite != null;
  }
  //Offset brings the movies after x, example 
  //If offset is 10, bring the movies after the next 10
  @override
  Future<List<ItemEntity>> loadFavoriteMovies({int limit = 9, int offset = 0}) async{
    final isar = await database;
    return isar.itemEntitys.where()
    .offset(offset)
    .limit(limit)
    .findAll();
    
  }

  //We save, update or delete when tap favorite icon
  @override
  Future<void> toggleFavorite(ItemEntity movie) async{
    
    final isar = await database;
    final favoriteItem = await isar.itemEntitys
    .filter()
    .idEqualTo(movie.id)
    .findFirst();

    if(favoriteItem != null ){
      //Delete 
      //We use the id to use(favoriteMovie.id) because it has a unique id
      isar.writeTxnSync(() => isar.itemEntitys.deleteSync(favoriteItem.isarId!));
      return;
    }
    //Insert 
    isar.writeTxnSync(() => isar.itemEntitys.putSync(movie));
  }

}