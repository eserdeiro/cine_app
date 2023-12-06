import 'package:cine_app/domain/entities/genre_entity.dart';
import 'package:intl/intl.dart';

class Formats {

  static String number(double number, int decimalDigits) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      symbol: '',
      locale: 'en'
    ).format(number);
    return formattedNumber;
  }

static String genreIdsToNames(List<String> itemGenreIds, List<GenreEntity> genresProvider) {
    List<GenreEntity> matchingGenres = genresProvider
        .where((genre) => itemGenreIds.contains(genre.id.toString()))
        .toList();

    List<String> genreNames = matchingGenres.map((genre) => genre.name).toList();

    return genreNames.join(', ');
    
  }

}


