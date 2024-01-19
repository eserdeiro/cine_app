import 'package:cine_app/config/constants/typedefs.dart';
import 'package:cine_app/domain/datasources/genres_datasource.dart';
import 'package:cine_app/domain/repository/genres_repository.dart';

class GenresRepositoryImpl extends GenresRepository {
  final GenresDatasource datasource;

  GenresRepositoryImpl(this.datasource);

  @override
  FutureListGenreEntity getGenres() => 
      datasource.getMovieGenres();
}
