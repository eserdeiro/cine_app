import 'package:dio/dio.dart';
import 'package:cine_app/config/constants/environment.dart';
import 'package:cine_app/domain/datasources/movies_datasource.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/infrastructure/mappers/mappers.dart';
import 'package:cine_app/infrastructure/models/models.dart';

class TheMovieDbDataSource extends MoviesDataSource {

    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        queryParameters: {
          'api_key': Enviroment.theMovieDbKey,
          'language': 'es-ARG'
        })
    );

  List<ItemEntity> _jsonToMovies(Map<String, dynamic> json){
     final movieDbResponse = MovieDbResponse.fromJson(json);
    final List<ItemEntity> movies = movieDbResponse.results
    .map(
      (movieDb) => MovieMapper.movieDbToEntity(movieDb))
       .where((moviedb) => moviedb.posterPath != 'no-poster' )
    .toList();
    return movies;  
  }

  //NowPlaying
  @override
  Future<List<ItemEntity>> getNowPlaying({int page = 1}) async { 
        final response = await dio.get('/movie/now_playing',
    queryParameters: { 
      'page' : page
      });
    return _jsonToMovies(response.data);
  }

  //GetPopular
  @override
  Future<List<ItemEntity>> getPopular({int page = 1}) async{
    final response = await dio.get('/movie/popular',
    queryParameters: { 
      'page' : page
      });
    return _jsonToMovies(response.data);
  }
  
  //GetUpcoming
  @override
  Future<List<ItemEntity>> getUpcoming({int page = 1}) async {
   final response = await dio.get('/movie/upcoming',
    queryParameters: { 
      'page' : page
      });
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<ItemEntity>> getTopRated({int page = 1}) async{
   final response = await dio.get('/movie/top_rated',
    queryParameters: { 
      'page' : page
      });
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<ItemEntity> getMovieById(String id) async{
    final response = await dio.get('/movie/$id',);
    if(response.statusCode != 200) throw Exception('Movie with id $id not found');
    final movieDetails = MovieDetails.fromJson(response.data);
    final ItemEntity movie = MovieMapper.movieDetailstoEntity(movieDetails);
    return movie;
  }
  
  @override
  Future<List<ItemEntity>> searchMoviesByQuery(String query) async{
       if(query.isEmpty) return [];
      final response = await dio.get('/search/movie',
    queryParameters: { 
      'query' : query
      });
    return _jsonToMovies(response.data);
  }
  
}