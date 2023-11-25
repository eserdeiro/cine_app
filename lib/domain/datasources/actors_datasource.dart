import 'package:cine_app/domain/entities/actor_entity.dart';

abstract class ActorsDatasource {

  Future<List<Actor>> getActorsByMovie (String movieId);

}