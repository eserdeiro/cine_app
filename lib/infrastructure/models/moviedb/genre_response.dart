import 'dart:convert';

GenreResponse castResponseFromJson(String str) => GenreResponse.fromJson(json.decode(str));

String castResponseToJson(GenreResponse data) => json.encode(data.toJson());

class GenreResponse {
    final List<GenreDates> genres;

    GenreResponse({
        required this.genres,
    });

    factory GenreResponse.fromJson(Map<String, dynamic> json) => GenreResponse(
        genres: List<GenreDates>.from(json["genres"].map((x) => GenreDates.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    };
}

class GenreDates {
    final int id;
    final String name;

    GenreDates({
        required this.id,
        required this.name,
    });

    factory GenreDates.fromJson(Map<String, dynamic> json) => GenreDates(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
