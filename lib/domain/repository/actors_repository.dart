import 'package:cine_app/config/constants/typedefs.dart';

abstract class ActorsRepository {
  FutureListActorEntity getCastByItem(String itemId);

  FutureListActorEntity getCrewByItem(String itemId);
}
