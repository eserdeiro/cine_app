import 'package:cine_app/config/constants/environment.dart';
import 'package:cine_app/domain/datasources/movies_datasource.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:cine_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cine_app/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class TheMovieDbDataSource extends MoviesDataSource {

    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        queryParameters: {
          'api_key': Enviroment.theMovieDbKey,
          'language': 'es-ARG'
        })
    );

  List<Movie> _jsonToMovies(Map<String, dynamic> json){
     final movieDbResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movieDbResponse.results
    //.where((moviedb) => (moviedb.posterPath != 'no-poster'))
    .map(
      (movieDb) => MovieMapper.movieDbToEntity(movieDb))
    .toList();
    return movies;  
  }
  //NowPlaying
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing',
    queryParameters: { 
      'page' : page
      });
    final movieDbResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieDbResponse.results
    //.where((moviedb) => (moviedb.posterPath != 'no-poster'))
    .map(
      (movieDb) => MovieMapper.movieDbToEntity(movieDb))
    .toList();
    return movies;  
  }

  //GetPopular optimized(_jsonToMovies), TODO do the same in getNowPlaying
  @override
  Future<List<Movie>> getPopular({int page = 1}) async{
    final response = await dio.get('/movie/popular',
    queryParameters: { 
      'page' : page
      });
    return _jsonToMovies(response.data);
  }
}