class ActorEntity {
  ActorEntity({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.character,
    required this.job,
  });

  final int id;
  final String name;
  final String profilePath;
  final String? character;
  final String? job;
}
