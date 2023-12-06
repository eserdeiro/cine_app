import 'package:cine_app/domain/entities/actor_entity.dart';

abstract class ActorsRepository {

  Future<List<ActorEntity>> getCastByItem (String itemId);

  Future<List<ActorEntity>> getCrewByItem (String itemId);
}