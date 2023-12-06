import 'dart:convert';

GenreFromMovieDb castResponseFromJson(String str) => GenreFromMovieDb.fromJson(json.decode(str));

String castResponseToJson(GenreFromMovieDb data) => json.encode(data.toJson());

class GenreFromMovieDb {
    final List<GenreFromGenresMovieDb> genres;

    GenreFromMovieDb({
        required this.genres,
    });

    factory GenreFromMovieDb.fromJson(Map<String, dynamic> json) => GenreFromMovieDb(
        genres: List<GenreFromGenresMovieDb>.from(json["genres"].map((x) => GenreFromGenresMovieDb.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    };
}

class GenreFromGenresMovieDb {
    final int id;
    final String name;

    GenreFromGenresMovieDb({
        required this.id,
        required this.name,
    });

    factory GenreFromGenresMovieDb.fromJson(Map<String, dynamic> json) => GenreFromGenresMovieDb(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
