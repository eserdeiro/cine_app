import 'package:cine_app/infrastructure/datasources/actor_from_moviedb_datasource_impl.dart';
import 'package:cine_app/infrastructure/repository/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//Read only
final actorsRepositoryProvider = Provider((ref) {
//If you want to change the source, change TheMovieDbDataSource to something else, example ImdbDataSource
  return ActorsRepositoryImpl(datasource: ActorFromMovieDbDatasource());
});