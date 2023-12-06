

import 'package:cine_app/domain/entities/genre_entity.dart';

abstract class GenresRepository {

   Future<List<GenreData>> getGenres ();

}