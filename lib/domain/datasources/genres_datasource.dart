
import 'package:cine_app/domain/entities/genre_entity.dart';

typedef FutureListGenreEntity = Future<List<GenreEntity>>;

abstract class GenresDatasource {

  FutureListGenreEntity getMovieGenres ();

}
