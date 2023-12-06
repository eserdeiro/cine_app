
import 'package:cine_app/domain/entities/genre_entity.dart';

abstract class GenresDatasource {

  Future<List<GenreData>> getGenres ();

}