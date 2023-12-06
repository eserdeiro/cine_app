import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:cine_app/infrastructure/models/models.dart'; 
class MovieMapper {
  //This is used to get the list of movies, for nowplaying, popular, etc.
  static Movie movieDbToEntity(MovieFromMovieDbResponse movieDb) => Movie(

      adult       : movieDb.adult,
      backdropPath: (movieDb.backdropPath != '') 
          ? 'https://image.tmdb.org/t/p/w1280/${movieDb.backdropPath}' 
          : 'no-poster',
      genreIds    : movieDb.genreIds.map((e) => e.toString()).toList(),
      id          : movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle   : movieDb.originalTitle,
      overview    : (movieDb.overview != '')? movieDb.overview : 'sdfdsf',
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
      static Movie movieDetailstoEntity(MovieDetails movieDetails) => Movie(
        adult: movieDetails.adult, 
        backdropPath: (movieDetails.backdropPath != '') 
          ? 'https://image.tmdb.org/t/p/w1280/${movieDetails.backdropPath}' 
          : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
        genreIds: movieDetails.genres.map((e) => e.name).toList(), 
        id: movieDetails.id, 
        originalLanguage: movieDetails.originalLanguage, 
        originalTitle: movieDetails.originalTitle, 
        overview: movieDetails.overview , 
        popularity: movieDetails.popularity, 
        posterPath: (movieDetails.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${movieDetails.posterPath}' 
          : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
        releaseDate: movieDetails.releaseDate, 
        title: movieDetails.title, 
        video: movieDetails.video, 
        voteAverage: movieDetails.voteAverage, 
        voteCount: movieDetails.voteCount
        );
}
