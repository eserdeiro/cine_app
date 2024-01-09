import 'package:cine_app/domain/entities/genre_entity.dart';
import 'package:cine_app/presentation/providers/genres/genre_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genresDataNotifierProvider =
    StateNotifierProvider<GenresDataNotifier, List<GenreEntity>>(
  GenresDataNotifier.new,
);

class GenresData {
  List<GenreEntity> genres;

  GenresData({required this.genres});
}

class GenresDataNotifier extends StateNotifier<List<GenreEntity>> {
  GenresDataNotifier(ref) : super([]) {
    _loadGenres(ref);
  }

  Future<void> _loadGenres(ref) async {
    final genres = await ref.watch(genreRepositoryProvider).getGenres();
    state = GenresData(genres: genres).genres;
  }
}
