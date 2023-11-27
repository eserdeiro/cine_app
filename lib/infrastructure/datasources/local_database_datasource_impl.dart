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

  @override
  Future<bool> isMoviefavorite(int movieId) {
    // TODO: implement isMoviefavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({int limit = 10, int offset = 0}) {
    // TODO: implement loadFavoriteMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }

}