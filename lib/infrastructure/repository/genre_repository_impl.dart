import 'package:cine_app/domain/datasources/genres_datasource.dart';
import 'package:cine_app/domain/entities/genre_entity.dart';
import 'package:cine_app/domain/repository/genres_repository.dart';

typedef FutureListGenreEntity = Future<List<GenreEntity>>;

class GenresRepositoryImpl extends GenresRepository{

  final GenresDatasource datasource;

  GenresRepositoryImpl(this.datasource);

  @override
  FutureListGenreEntity getGenres() {
    return datasource.getMovieGenres();
  }
  
}
