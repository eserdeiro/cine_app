import 'package:cine_app/domain/entities/actor_entity.dart';

abstract class ActorsDatasource {

  Future<List<ActorEntity>> getCastByMovie (String movieId);

  Future<List<ActorEntity>> getCrewByMovie (String movieId);
}