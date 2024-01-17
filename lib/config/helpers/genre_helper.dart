import 'package:cine_app/domain/entities/genre_entity.dart';

class GenreHelper {
  static String genreIdsToNames(
    List<String> itemGenreIds,
    List<GenreEntity> genresProvider,
  ) {
    final matchingGenres = genresProvider
        .where((genre) => itemGenreIds.contains(genre.id.toString()))
        .toList();

    final genreNames = matchingGenres.map((genre) => genre.name).toList();

    return genreNames.join(', ');
  }
}
