import 'package:cine_app/domain/datasources/actors_datasource.dart';
import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/domain/repository/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository{

  final ActorsDatasource datasource;

  ActorsRepositoryImpl({required this.datasource});

  @override
  Future<List<Actor>> getCastByMovie(String movieId) {
    return datasource.getCastByMovie(movieId);
  }

  @override
  Future<List<Actor>> getCrewByMovie(String movieId) {
    return datasource.getCrewByMovie(movieId);
  }
  
}