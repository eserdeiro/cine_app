import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/domain/repository/local_database_repository.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider = StateNotifierProvider<DatabaseMoviesNotifier, Map<int, ItemEntity>>((ref) {
  final localDatabaseRepository = ref.watch(localDatabaseProvider);
  return DatabaseMoviesNotifier(localDatabaseRepository: localDatabaseRepository);

});


class DatabaseMoviesNotifier extends StateNotifier<Map<int, ItemEntity>>{

  int page = 0;
  final LocalDatabaseRepository localDatabaseRepository;

  DatabaseMoviesNotifier({required this.localDatabaseRepository}) : super({});

  Future<List<ItemEntity>> loadNextPage() async {

    final movies = await localDatabaseRepository.loadFavoriteMovies(offset: page * 10, limit: 12); // 
    page++;

    final tempMovieMap = <int, ItemEntity>{};

    for(final movie in movies ){
      tempMovieMap[movie.id] = movie;
    }

    state = {...state, ...tempMovieMap};

    return movies;
    }

  Future<void> toggleFavorite(ItemEntity movie) async{
    await localDatabaseRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if(isMovieInFavorites){
      state.remove(movie.id);
      state = {...state};
    }
    else {
      state = {...state, movie.id: movie};
    }
  }

}