import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:cine_app/domain/repository/local_database_repository.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider = StateNotifierProvider<DatabaseMoviesNotifier, Map<int, Movie>>((ref) {
  final localDatabaseRepository = ref.watch(localDatabaseProvider);
  return DatabaseMoviesNotifier(localDatabaseRepository: localDatabaseRepository);

});


class DatabaseMoviesNotifier extends StateNotifier<Map<int, Movie>>{

  int page = 0;
  final LocalDatabaseRepository localDatabaseRepository;

  DatabaseMoviesNotifier({required this.localDatabaseRepository}) : super({});

  Future<void> loadNextPage() async {

    final movies = await localDatabaseRepository.loadFavoriteMovies(offset: page * 10); // 
    page++;

    final tempMovieMap = <int, Movie>{};

    for(final movie in movies ){
      tempMovieMap[movie.id] = movie;
    }

    state = {...state, ...tempMovieMap};

    }


}