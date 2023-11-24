import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider).getActorsByMovie;

  return ActorsByMovieNotifier(getActors: actorsRepository);
});

typedef GetActorsCallback = Future<List<Actor>>Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>>{

  final GetActorsCallback getActors;
//  Maps each movie and maintains the cache in memory 
  ActorsByMovieNotifier({
      required this.getActors
      }) : super({});

  Future<void> loadActors(String movieId) async{
    if(state[movieId] != null ) return;
    final actors = await getActors( movieId );
    state = {...state, movieId : actors};
  }

}