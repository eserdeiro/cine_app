import 'package:cine_app/domain/datasources/genres_datasource.dart';
import 'package:cine_app/domain/entities/genre_entity.dart';
import 'package:cine_app/domain/repository/genres_repository.dart';

class GenresRepositoryImpl extends GenresRepository{

  final GenresDatasource datasource;

  GenresRepositoryImpl({required this.datasource});

  @override
  Future<List<GenreData>> getGenres() {
    return datasource.getGenres();
  }
  
}