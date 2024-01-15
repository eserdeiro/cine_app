import 'package:cine_app/config/helpers/api_provider.dart';
import 'package:cine_app/domain/datasources/actors_datasource.dart';
import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/infrastructure/mappers/index.dart';
import 'package:cine_app/infrastructure/models/moviedb/credits_response.dart';


class ActorFromMovieDbDatasource extends ActorsDatasource {
  final dio = ApiProvider.dio;

  @override
  Future<List<ActorEntity>> getCastByItem(String itemId) async {
    final response = await dio.get('/movie/$itemId/credits');
    
    final castResponse = CreditsResponse.fromJson(response.data);

    final cast = castResponse.cast
        .map(
          ActorMapper.actorToEntity,
        )
        .toList();
    return cast;
  }

  @override
  Future<List<ActorEntity>> getCrewByItem(String itemId) async {
    final response = await dio.get('/movie/$itemId/credits');
    
    final castResponse = CreditsResponse.fromJson(response.data);

    final crew = castResponse.crew
        .map(
          ActorMapper.actorToEntity,
        )
        .toList();
    return crew;
  }
}
