import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final castByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final castRepository = ref.watch(actorsRepositoryProvider).getCastByMovie;

  return ActorsByMovieNotifier(getActors: castRepository);
});

final crewByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final crewsRepository = ref.watch(actorsRepositoryProvider).getCrewByMovie;

  return ActorsByMovieNotifier(getActors: crewsRepository);
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