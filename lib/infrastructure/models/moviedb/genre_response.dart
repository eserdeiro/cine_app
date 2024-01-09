import 'dart:convert';

GenreResponse castResponseFromJson(String str) => GenreResponse.fromJson(json.decode(str));

String castResponseToJson(GenreResponse data) => json.encode(data.toJson());

class GenreResponse {
    final List<GenreFromMovieDb> genres;

    GenreResponse({
        required this.genres,
    });

    factory GenreResponse.fromJson(Map<String, dynamic> json) => GenreResponse(
        genres: List<GenreFromMovieDb>.from(json['genres'].map((x) => GenreFromMovieDb.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'genres': List<dynamic>.from(genres.map((x) => x.toJson())),
    };
}

class GenreFromMovieDb {
    final int id;
    final String name;

    GenreFromMovieDb({
        required this.id,
        required this.name,
    });

    factory GenreFromMovieDb.fromJson(Map<String, dynamic> json) => GenreFromMovieDb(
        id: json['id'],
        name: json['name'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
    };
}
