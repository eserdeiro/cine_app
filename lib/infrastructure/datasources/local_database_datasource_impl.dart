import 'package:cine_app/domain/datasources/local_database_datasource.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
//isarDatasource
class LocalDatabaseDataSourceImpl extends LocalDatabaseDatasource{

  late Future<Isar> database;

  LocalDatabaseDataSourceImpl(){
    database = openDB();
  }

  Future<Isar> openDB() async{
    final dir = await getApplicationCacheDirectory();
    if(Isar.instanceNames.isEmpty){
      return await Isar.open([MovieSchema], directory: dir.path, inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  //Check each movie if it is favorite or not, by id
  @override
  Future<bool> isMoviefavorite(int movieId) async{
    
    final isar = await database;
    final Movie? isMovieFavorite = await isar.movies
    .filter()
    .idEqualTo(movieId)
    .findFirst();

    return isMovieFavorite != null;
  }
  //Offset brings the movies after x, example 
  //If offset is 10, bring the movies after the next 10
  @override
  Future<List<Movie>> loadFavoriteMovies({int limit = 10, int offset = 0}) async{
    final isar = await database;
    return isar.movies.where()
    .offset(offset)
    .limit(limit)
    .findAll();
    
  }

  //We save, update or delete when tap favorite icon
  @override
  Future<void> toggleFavorite(Movie movie) async{
    
    final isar = await database;
    final favoriteMovie = await isar.movies
    .filter()
    .idEqualTo(movie.id)
    .findFirst();

    if(favoriteMovie != null ){
      //Delete 
      //We use the id to use(favoriteMovie.id) because it has a unique id
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }
    //Insert 
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

}