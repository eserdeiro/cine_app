import 'package:cine_app/config/constants/typedefs.dart';

abstract class ActorsDatasource {

  FutureListActorEntity getCastByItem (String itemId);

  FutureListActorEntity getCrewByItem (String itemId);
  
}
