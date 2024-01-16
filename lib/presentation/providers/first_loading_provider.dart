import 'package:cine_app/presentation/providers/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//When all providers load, return true, & the fullscreen loader closes
final firstLoadingProvider = Provider<bool>((ref) {
  final providers = <dynamic>[
    popularMoviesProvider,
    upcomingMoviesProvider,
    topRatedMoviesProvider,
    moviesSlideshowProvider,
    genresDataNotifierProvider,
  ];

  for (final provider in providers) {
    if (ref.watch(provider).isEmpty) {
      return true;
    }
  }

  return false;
});
