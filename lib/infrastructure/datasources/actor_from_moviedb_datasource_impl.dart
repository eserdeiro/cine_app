import 'package:cine_app/config/constants/typedefs.dart';
import 'package:cine_app/config/helpers/api_provider.dart';
import 'package:cine_app/domain/datasources/actors_datasource.dart';
import 'package:cine_app/infrastructure/mappers/index.dart';
import 'package:cine_app/infrastructure/models/moviedb/actors_response.dart';

class ActorFromMovieDbDatasource extends ActorsDatasource {
  final dio = ApiProvider.dio;

  FutureListActorEntity _getActorsByItem(
    String itemId,
    List<Actor> Function(ActorsResponse) selector,
  ) async {
    final dioResponse = await dio.get('/movie/$itemId/credits');
    final actorResponse = ActorsResponse.fromJson(dioResponse.data);
    final actorsData = selector(actorResponse);
    return actorsData.map(ActorMapper.actorToEntity).toList();
  }

  @override
  FutureListActorEntity getCastByItem(String itemId) async {
    return _getActorsByItem(itemId, (castResponse) => castResponse.cast);
  }

  @override
  FutureListActorEntity getCrewByItem(String itemId) async {
    return _getActorsByItem(itemId, (castResponse) => castResponse.crew);
  }
}
