import 'package:cine_app/config/constants/typedefs.dart';
import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/presentation/providers/index.dart';

enum ActorType { cast, crew }

StateNotifierProviderActors newActorByItemProvider(ActorType type) {
  return StateNotifierProviderActors(
    (ref) {
      final actorsRepository = ref.watch(actorsRepositoryProvider);
      FutureListActorEntity getActors(String itemId) {
        switch (type) {
          case ActorType.cast:
            return actorsRepository.getCastByItem(itemId);
          case ActorType.crew:
            return actorsRepository.getCrewByItem(itemId);
        }
      }

      return ActorsByItemNotifier(getActors: getActors);
    },
  );
}

final castByItemProvider = newActorByItemProvider(ActorType.cast);
final crewByItemProvider = newActorByItemProvider(ActorType.crew);

typedef GetActorsCallback = Future<List<ActorEntity>> Function(String itemId);

class ActorsByItemNotifier extends LoadNotifier<List<ActorEntity>> {
  final GetActorsCallback getActors;

  ActorsByItemNotifier({
    required this.getActors,
  }) : super(getItem: (itemId) => getActors(itemId));
}
