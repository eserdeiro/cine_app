import 'package:cine_app/infrastructure/datasources/themoviedb_datasource_impl.dart';
import 'package:cine_app/infrastructure/repository/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//Read only
final movieRepositoryProvider = Provider((ref) {
//If you want to change the source, change TheMovieDbDataSource to something else, example ImdbDataSource
  return MovieRepositoryImpl(datasource: TheMovieDbDataSource());
});
