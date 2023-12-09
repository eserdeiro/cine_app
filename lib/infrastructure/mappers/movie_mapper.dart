import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/infrastructure/models/models.dart'; 
class MovieMapper {
  //This is used to get the list of movies, for nowplaying, popular, etc.
  static ItemEntity movieDbToEntity(MovieFromMovieDbResponse movieDb) => ItemEntity(

      adult       : movieDb.adult,
      backdropPath: (movieDb.backdropPath != '') 
          ? 'https://image.tmdb.org/t/p/w1280/${movieDb.backdropPath}' 
          : 'no-poster',
      genreIds    : movieDb.genreIds.map((e) => e.toString()).toList(),
      id          : movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle   : movieDb.originalTitle,
      overview    : movieDb.overview,
      popularity  : movieDb.popularity,
      posterPath  : (movieDb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${movieDb.posterPath}' 
          : 'no-poster',
      releaseDate : movieDb.releaseDate != null ? movieDb.releaseDate! : null,
      title       : movieDb.title,
      video       : movieDb.video,
      voteAverage : movieDb.voteAverage,
      voteCount   : movieDb.voteCount
      );

      //This is used to get movies by id
      static ItemEntity movieDetailstoEntity(MovieDetails movieDetails) => ItemEntity(
        adult: movieDetails.adult, 
        backdropPath: (movieDetails.backdropPath != '') 
          ? 'https://image.tmdb.org/t/p/w1280/${movieDetails.backdropPath}' 
          : 'https://raw.githubusercontent.com/eserdeiro/cine_app/main/lib/assets/images/not-found.jpeg',
        genreIds: movieDetails.genres.map((e) => e.name).toList(), 
        id: movieDetails.id, 
        originalLanguage: movieDetails.originalLanguage, 
        originalTitle: movieDetails.originalTitle, 
        overview: (movieDetails.overview != '') 
        ? movieDetails.overview 
        : 'No overview available' , 
        popularity: movieDetails.popularity, 
        posterPath: (movieDetails.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${movieDetails.posterPath}' 
          : 'https://raw.githubusercontent.com/eserdeiro/cine_app/main/lib/assets/images/not-found.jpeg',
        releaseDate: movieDetails.releaseDate, 
        title: movieDetails.title, 
        video: movieDetails.video, 
        voteAverage: movieDetails.voteAverage, 
        voteCount: movieDetails.voteCount
        );
}
