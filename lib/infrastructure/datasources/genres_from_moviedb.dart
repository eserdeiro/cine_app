import 'package:cine_app/config/constants/environment.dart';
import 'package:cine_app/domain/datasources/genres_datasource.dart';
import 'package:cine_app/domain/entities/genre_entity.dart';
import 'package:cine_app/infrastructure/mappers/mappers.dart';
import 'package:cine_app/infrastructure/models/moviedb/genre_response.dart';
import 'package:dio/dio.dart';

class GenresFromMovieDb extends GenresDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': 'en-US',
      },
    ),
  );

  @override
  Future<List<GenreEntity>> getMovieGenres() async {
    final response = await dio.get('/genre/movie/list');

    final genresResponse = GenreResponse.fromJson(response.data);

    final genres =
        genresResponse.genres.map(GenresMapper.genreToEntity).toList();
    return genres;
  }
}
