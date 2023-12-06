import 'package:cine_app/infrastructure/datasources/genres_from_moviedb.dart';
import 'package:cine_app/infrastructure/repository/genre_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Inmutable repository
final genreRepositoryProvider = Provider((ref) {
  return GenresRepositoryImpl(GenresFromMovieDb());
});