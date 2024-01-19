import 'package:cine_app/config/constants/typedefs.dart';
import 'package:cine_app/domain/datasources/actors_datasource.dart';
import 'package:cine_app/domain/repository/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorsRepositoryImpl({required this.datasource});

  @override
  FutureListActorEntity getCastByItem(String itemId) =>
      datasource.getCastByItem(itemId);

  @override
  FutureListActorEntity getCrewByItem(String itemId) =>
      datasource.getCrewByItem(itemId);
}
