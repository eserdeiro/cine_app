import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final castByItemProvider = StateNotifierProvider<ActorsByItemNotifier, Map<String, List<ActorEntity>>>((ref) {
  final castRepository = ref.watch(actorsRepositoryProvider).getCastByItem;

  return ActorsByItemNotifier(getActors: castRepository);
});

final crewByItemProvider = StateNotifierProvider<ActorsByItemNotifier, Map<String, List<ActorEntity>>>((ref) {
  final crewsRepository = ref.watch(actorsRepositoryProvider).getCrewByItem;

  return ActorsByItemNotifier(getActors: crewsRepository);
});

typedef GetActorsCallback = Future<List<ActorEntity>>Function(String itemId);

class ActorsByItemNotifier extends StateNotifier<Map<String, List<ActorEntity>>>{

  final GetActorsCallback getActors;
//  Maps each movie and maintains the cache in memory 
  ActorsByItemNotifier({
      required this.getActors
      }) : super({});

  Future<void> loadActors(String itemId) async{
    if(state[itemId] != null ) return;
    final actors = await getActors( itemId );
    state = {...state, itemId : actors};
  }

}