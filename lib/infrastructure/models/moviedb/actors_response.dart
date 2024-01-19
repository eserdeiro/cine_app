class ActorsResponse {
  final int id;
  final List<Actor> cast;
  final List<Actor> crew;

  ActorsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory ActorsResponse.fromJson(Map<String, dynamic> json) => ActorsResponse(
        id: json['id'],
        cast: List<Actor>.from(json['cast'].map((x) => Actor.fromJson(x))),
        crew: List<Actor>.from(json['crew'].map((x) => Actor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cast': List<dynamic>.from(cast.map((x) => x.toJson())),
        'crew': List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}

class Actor {
  final int gender;
  final int id;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String creditId;
  final String? department;
  final String? job;

  Actor({
    required this.gender,
    required this.id,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.creditId,
    this.castId,
    this.character,
    this.department,
    this.job,
  });

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        gender: json['gender'],
        id: json['id'],
        name: json['name'],
        originalName: json['original_name'],
        popularity: json['popularity']?.toDouble(),
        profilePath: json['profile_path'],
        castId: json['cast_id'],
        character: json['character'],
        creditId: json['credit_id'],
        department: json['department'],
        job: json['job'],
      );

  Map<String, dynamic> toJson() => {
        'gender': gender,
        'id': id,
        'name': name,
        'original_name': originalName,
        'popularity': popularity,
        'profile_path': profilePath,
        'cast_id': castId,
        'character': character,
        'credit_id': creditId,
        'department': department,
        'job': job,
      };
}
