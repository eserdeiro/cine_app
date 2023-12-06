import 'package:cine_app/domain/entities/genre_entity.dart';
import 'package:cine_app/infrastructure/models/moviedb/genre_response.dart';

class GenresMapper {

  static GenreEntity genreToEntity(GenreFromMovieDb genre) => GenreEntity(
    id: genre.id, 
    name: genre.name, 
    );
}