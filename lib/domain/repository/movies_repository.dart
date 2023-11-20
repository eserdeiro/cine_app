import 'package:cine_app/domain/entities/movie_entity.dart';

abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({int page = 1});

}