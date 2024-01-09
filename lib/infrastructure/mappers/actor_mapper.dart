import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/infrastructure/models/index.dart';

class ActorMapper {

  static ActorEntity castToEntity(Cast cast)=> ActorEntity(
    id: cast.id, 
    name: cast.name, 
    profilePath: (cast.profilePath != null)
     ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}' 
     : 'https://raw.githubusercontent.com/eserdeiro/cine_app/main/lib/assets/images/not-found.jpeg', 
    character: cast.character,
    job: cast.job,
    );
}
