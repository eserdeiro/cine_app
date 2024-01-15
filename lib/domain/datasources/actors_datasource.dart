import 'package:cine_app/domain/entities/actor_entity.dart';

typedef FutureListActorEntity = Future<List<ActorEntity>>;

abstract class ActorsDatasource {

  FutureListActorEntity getCastByItem (String itemId);

  FutureListActorEntity getCrewByItem (String itemId);
}
