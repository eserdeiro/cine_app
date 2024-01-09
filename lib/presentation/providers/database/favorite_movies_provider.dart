import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/domain/repository/local_database_repository.dart';
import 'package:cine_app/presentation/providers/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteItemsProvider = StateNotifierProvider<DatabaseItemsNotifier, Map<int, ItemEntity>>((ref) {
  final localDatabaseRepository = ref.watch(localDatabaseProvider);
  return DatabaseItemsNotifier(localDatabaseRepository: localDatabaseRepository);

});


class DatabaseItemsNotifier extends StateNotifier<Map<int, ItemEntity>>{

  int page = 0;
  final LocalDatabaseRepository localDatabaseRepository;

  DatabaseItemsNotifier({required this.localDatabaseRepository}) : super({});

  Future<List<ItemEntity>> loadNextPage() async {

    final items = await localDatabaseRepository.loadFavoriteItems(offset: page * 10, limit: 12); // 
    page++;

    final tempItemMap = <int, ItemEntity>{};

    for(final movie in items ){
      tempItemMap[movie.id] = movie;
    }

    state = {...state, ...tempItemMap};

    return items;
    }

  Future<void> toggleFavorite(ItemEntity item) async{
    await localDatabaseRepository.toggleFavorite(item);
    final isItemInFavorites = state[item.id] != null;

    if(isItemInFavorites){
      state.remove(item.id);
      state = {...state};
    }
    else {
      state = {...state, item.id: item};
    }
  }

}
