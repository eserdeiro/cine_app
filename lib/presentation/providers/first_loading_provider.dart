import 'package:cine_app/presentation/providers/genres/genres_providers.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//when all providers load, return '', & the fullscreen loader closes
final firstLoadingProvider = Provider<bool>((ref){

    final popularMovies     = ref.watch(popularMoviesProvider).isEmpty;
    final upcomingMovies    = ref.watch(upcomingMoviesProvider).isEmpty;
    final topRatedMovies    = ref.watch(topRatedMoviesProvider).isEmpty;
    final slideshowProvider = ref.watch(moviesSlideshowProvider).isEmpty;
    final genresData        = ref.watch(genresDataNotifierProvider).isEmpty;

if(popularMovies || upcomingMovies || topRatedMovies || slideshowProvider || genresData) return true;
return false;
});
