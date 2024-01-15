import 'dart:convert';

GenreResponse castResponseFromJson(String str) => GenreResponse.fromJson(json.decode(str));

String castResponseToJson(GenreResponse data) => json.encode(data.toJson());

class GenreResponse {
    final List<Genre> genres;

    GenreResponse({
        required this.genres,
    });

    factory GenreResponse.fromJson(Map<String, dynamic> json) => GenreResponse(
        genres: List<Genre>.from(json['genres'].map((x) => Genre.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'genres': List<dynamic>.from(genres.map((x) => x.toJson())),
    };
}

class Genre {
    final int id;
    final String name;

    Genre({
        required this.id,
        required this.name,
    });

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'],
        name: json['name'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
    };
}
