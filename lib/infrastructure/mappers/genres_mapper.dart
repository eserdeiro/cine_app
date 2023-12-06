import 'package:cine_app/domain/entities/genre_entity.dart';
import 'package:cine_app/infrastructure/models/moviedb/genre_response.dart';

class GenresMapper {

  static GenreData genreToEntity(GenreDates genre) => GenreData(
    id: genre.id, 
    name: genre.name, 
    );
}