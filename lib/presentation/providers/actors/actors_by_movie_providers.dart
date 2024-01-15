import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/presentation/providers/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final castByItemProvider =
    StateNotifierProvider<ActorsByItemNotifier, Map<String, List<ActorEntity>>>(
        (ref) {
  final castRepository = ref.watch(actorsRepositoryProvider).getCastByItem;

  return ActorsByItemNotifier(getActors: castRepository);
});

final crewByItemProvider =
    StateNotifierProvider<ActorsByItemNotifier, Map<String, List<ActorEntity>>>(
        (ref) {
  final crewsRepository = ref.watch(actorsRepositoryProvider).getCrewByItem;

  return ActorsByItemNotifier(getActors: crewsRepository);
});

typedef GetActorsCallback = Future<List<ActorEntity>> Function(String itemId);

class ActorsByItemNotifier extends LoadNotifier<List<ActorEntity>> {
  final GetActorsCallback getActors;

  ActorsByItemNotifier({
    required this.getActors,
  }) : super(getItem: (itemId) => getActors(itemId));
}
