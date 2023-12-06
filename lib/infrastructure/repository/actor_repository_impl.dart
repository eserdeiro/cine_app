import 'package:cine_app/domain/datasources/actors_datasource.dart';
import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/domain/repository/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository{

  final ActorsDatasource datasource;

  ActorsRepositoryImpl({required this.datasource});

  @override
  Future<List<ActorEntity>> getCastByMovie(String movieId) {
    return datasource.getCastByMovie(movieId);
  }

  @override
  Future<List<ActorEntity>> getCrewByMovie(String movieId) {
    return datasource.getCrewByMovie(movieId);
  }
  
}