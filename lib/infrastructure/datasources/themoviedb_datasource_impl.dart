import 'package:cine_app/config/constants/typedefs.dart';
import 'package:cine_app/config/helpers/api_provider.dart';
import 'package:cine_app/domain/datasources/movies_datasource.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/infrastructure/mappers/index.dart';
import 'package:cine_app/infrastructure/models/index.dart';

class TheMovieDbDataSource extends MoviesDataSource {
  

  final dio = ApiProvider.dio;

  List<ItemEntity> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);
    final movies = movieDbResponse.results
        .map(
          MovieMapper.movieDbToEntity,
        )
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .toList();
    return movies;
  }

  FutureListItemEntity getMovies(String path, {int page = 1}) async {
    final response = await dio.get(
      path,
      queryParameters: {
        'page': page,
      },
    );
    return _jsonToMovies(response.data);
  }

  // GetPopular
  @override
  FutureListItemEntity getNowPlaying({int page = 1}) async {
    return getMovies('/movie/now_playing', page: page);
  }

  // GetPopular
  @override
  FutureListItemEntity getPopular({int page = 1}) async {
    return getMovies('/movie/popular', page: page);
  }

// GetUpcoming
  @override
  FutureListItemEntity getUpcoming({int page = 1}) async {
    return getMovies('/movie/upcoming', page: page);
  }

//GetTopRated
  @override
  FutureListItemEntity getTopRated({int page = 1}) async {
    return getMovies('/movie/top_rated', page: page);
  }

//SearchMoviesByQuery
  @override
  FutureListItemEntity searchMoviesByQuery(String query) async {
    if (query.isEmpty) return [];
    final response = await dio.get(
      '/search/movie',
      queryParameters: {
        'query': query,
      },
    );
    return _jsonToMovies(response.data);
  }

//GetMovieById
  @override
  FutureItemEntity getMovieById(String id) async {
    final response = await dio.get(
      '/movie/$id',
    );
    if (response.statusCode != 200) {
      throw Exception('Movie with id $id not found');
    }
    final movieDetails = MovieDetails.fromJson(response.data);
    final movie = MovieMapper.movieDetailstoEntity(movieDetails);
    return movie;
  }
}
