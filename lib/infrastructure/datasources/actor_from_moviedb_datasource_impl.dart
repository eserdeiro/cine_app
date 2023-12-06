import 'package:dio/dio.dart';
import 'package:cine_app/config/constants/environment.dart';
import 'package:cine_app/domain/datasources/actors_datasource.dart';
import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/infrastructure/mappers/mappers.dart';
import 'package:cine_app/infrastructure/models/moviedb/credits_response.dart';

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
  Future<List<ActorEntity>> getCastByItem(String itemId) async{
    final response = await dio.get('/movie/$itemId/credits');
    //print('response ${response.data}');
    final castResponse = CreditsResponse.fromJson(response.data);

    //Crew also available
    List<ActorEntity> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();
  return actors;

  }
    @override
  Future<List<ActorEntity>> getCrewByItem(String itemId) async{
    final response = await dio.get('/movie/$itemId/credits');
    //print('response ${response.data}');
    final castResponse = CreditsResponse.fromJson(response.data);

    //Crew also available
    List<ActorEntity> actors = castResponse.crew.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();
  return actors;

  }
}
