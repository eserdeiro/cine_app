import 'package:cine_app/config/helpers/api_provider.dart';
import 'package:cine_app/domain/datasources/genres_datasource.dart';
import 'package:cine_app/domain/entities/genre_entity.dart';
import 'package:cine_app/infrastructure/mappers/index.dart';
import 'package:cine_app/infrastructure/models/moviedb/genre_response.dart';

typedef FutureListGenreEntity = Future<List<GenreEntity>>;

class GenresFromMovieDb extends GenresDatasource {
  
  final dio = ApiProvider.dio;

  @override
  FutureListGenreEntity getMovieGenres() async {

    final response = await dio.get('/genre/movie/list');

    final genresResponse = GenreResponse.fromJson(response.data);

    final genres =
        genresResponse.genres.map(GenresMapper.genreToEntity).toList();
    return genres;
  }
}
