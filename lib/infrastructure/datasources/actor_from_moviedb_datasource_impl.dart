import 'package:cine_app/config/constants/environment.dart';
import 'package:cine_app/domain/datasources/actors_datasource.dart';
import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/infrastructure/mappers/actor_mapper.dart';
import 'package:cine_app/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorFromMovieDbDatasource extends ActorsDatasource {  


  final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        queryParameters: {
          'api_key': Enviroment.theMovieDbKey,
          'language': 'es-ARG'
        })
    );
    
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{
    final response = await dio.get('/movie/$movieId/credits');
    //print('response ${response.data}');
    final castResponse = CreditsResponse.fromJson(response.data);

    //Crew also available
    List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();
  return actors;

  }
}
