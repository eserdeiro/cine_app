import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/infrastructure/models/index.dart';

class ItemMapper {

  static String buildImageWithoutPoster(String path, String size) {
    return (path != '')
        ? 'https://image.tmdb.org/t/p/$size/$path'
        : 'no-poster';
  }

    static String buildImageWithPoster(String path, String size) {
    return (path != '')
        ? 'https://image.tmdb.org/t/p/$size/$path'
        : 'https://raw.githubusercontent.com/eserdeiro/cine_app/main/lib/assets/images/not-found.jpeg';
  }

  //This is used to get the list of movies, for nowplaying, popular, etc.
  static ItemEntity movieDbToEntity(ItemFromMovieDbResponse itemMovieDb) =>
      ItemEntity(
        adult: itemMovieDb.adult,
        backdropPath: buildImageWithoutPoster(itemMovieDb.backdropPath, 'w780'),
        genreIds: itemMovieDb.genreIds.map((e) => e.toString()).toList(),
        id: itemMovieDb.id,
        originalLanguage: itemMovieDb.originalLanguage,
        originalTitle: itemMovieDb.originalTitle,
        overview: itemMovieDb.overview,
        popularity: itemMovieDb.popularity,
        posterPath: buildImageWithoutPoster(itemMovieDb.posterPath, 'w342'),
        releaseDate: itemMovieDb.releaseDate,
        title: itemMovieDb.title,
        video: itemMovieDb.video,
        voteAverage: itemMovieDb.voteAverage,
        voteCount: itemMovieDb.voteCount,
      );

  //This is used to get movies by id
  static ItemEntity itemDetailstoEntity(ItemDetails itemDetails) => ItemEntity(
        adult: itemDetails.adult,
        backdropPath: buildImageWithPoster(itemDetails.backdropPath, 'w780'),
        genreIds: itemDetails.genres.map((e) => e.name).toList(),
        id: itemDetails.id,
        originalLanguage: itemDetails.originalLanguage,
        originalTitle: itemDetails.originalTitle,
        overview: (itemDetails.overview != '')
            ? itemDetails.overview
            : 'No overview available',
        popularity: itemDetails.popularity,
        posterPath: buildImageWithPoster(itemDetails.posterPath, 'w500'),
        releaseDate: itemDetails.releaseDate,
        title: itemDetails.title,
        video: itemDetails.video,
        voteAverage: itemDetails.voteAverage,
        voteCount: itemDetails.voteCount,
      );
}
