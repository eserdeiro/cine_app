import 'package:cine_app/domain/entities/actor_entity.dart';

abstract class ActorsDatasource {

  Future<List<Actor>> getCastByMovie (String movieId);

  Future<List<Actor>> getCrewByMovie (String movieId);
}