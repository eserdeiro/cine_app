import 'package:cine_app/infrastructure/datasources/themoviedb_datasource.dart';
import 'package:cine_app/infrastructure/repository/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//Read only
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(datasource: TheMovieDbDataSource());
});