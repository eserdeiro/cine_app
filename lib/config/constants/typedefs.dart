import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/domain/entities/genre_entity.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/providers/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef FutureListItemEntity  = Future<List<ItemEntity>>;
typedef FutureItemEntity      = Future<ItemEntity>;
typedef FutureListActorEntity = Future<List<ActorEntity>>;
typedef FutureListGenreEntity = Future<List<GenreEntity>>;
typedef StateNotifierProviderActors = StateNotifierProvider<
    ActorsByItemNotifier, Map<String, List<ActorEntity>>>;
