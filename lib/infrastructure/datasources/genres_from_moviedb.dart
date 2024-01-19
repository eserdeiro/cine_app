import 'package:cine_app/config/constants/typedefs.dart';
import 'package:cine_app/config/helpers/api_provider.dart';
import 'package:cine_app/domain/datasources/genres_datasource.dart';
import 'package:cine_app/infrastructure/mappers/index.dart';
import 'package:cine_app/infrastructure/models/moviedb/genre_response.dart';


class GenresFromMovieDb extends GenresDatasource {
  
  final dio = ApiProvider.dio;

  @override
  FutureListGenreEntity getMovieGenres() async {

    final response = await dio.get('/genre/movie/list');

    final genreResponse = GenreResponse.fromJson(response.data);

    final genres =
        genreResponse.genres.map(GenresMapper.genreToEntity).toList();
    return genres;
  }
}
