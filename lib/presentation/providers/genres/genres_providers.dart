
import 'package:cine_app/domain/entities/genre_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genresDataNotifierProvider = StateNotifierProvider<GenresDataNotifier, GenresData>((ref) {
  return GenresDataNotifier();
});

class GenresData {
  List<GenreEntity> genres = [];
}

class GenresDataNotifier extends StateNotifier<GenresData> {
  GenresDataNotifier() : super(GenresData());

  void setGenres(List<GenreEntity> genres) {
    state = GenresData()..genres = genres;
  }
}