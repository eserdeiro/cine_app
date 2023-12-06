
import 'package:dio/dio.dart';
import 'package:cine_app/config/constants/environment.dart';
import 'package:cine_app/domain/datasources/genres_datasource.dart';
import 'package:cine_app/domain/entities/genre_entity.dart';
import 'package:cine_app/infrastructure/mappers/mappers.dart';
import 'package:cine_app/infrastructure/models/moviedb/genre_response.dart';

class GenresFromMovieDb extends GenresDatasource {

    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        queryParameters: {
          'api_key': Enviroment.theMovieDbKey,
          'language': 'es-ARG'
        })
    );
    
      @override
      Future<List<GenreEntity>> getGenres() async{
        final response = await dio.get('/genre/movie/list');
          
      final genresResponse = GenreResponse.fromJson(response.data);

      List<GenreEntity> genres = genresResponse.genres
          .map((genre) => GenresMapper.genreToEntity(genre))
          .toList();
      return genres;
        }
}


