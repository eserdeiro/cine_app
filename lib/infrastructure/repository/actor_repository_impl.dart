import 'package:cine_app/domain/datasources/actors_datasource.dart';
import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/domain/repository/actors_repository.dart';

typedef FutureListActorEntity = Future<List<ActorEntity>>;

class ActorsRepositoryImpl extends ActorsRepository{

  final ActorsDatasource datasource;

  ActorsRepositoryImpl({required this.datasource});

  @override
  FutureListActorEntity getCastByItem(String itemId) {
    return datasource.getCastByItem(itemId);
  }

  @override
  FutureListActorEntity getCrewByItem(String itemId) {
    return datasource.getCrewByItem(itemId);
  }
  
}
