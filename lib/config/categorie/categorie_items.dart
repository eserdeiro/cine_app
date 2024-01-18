import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/domain/entities/index.dart';
import 'package:cine_app/presentation/providers/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategorieItem {
  final String title;
  final StateNotifierProvider<MoviesNotifier, List<ItemEntity>> provider;
  final String url;

  const CategorieItem({
    required this.title,
    required this.provider,
    required this.url,
  });
}

final categorieItems = <CategorieItem>[
  CategorieItem(
    title: Strings.nowPlaying,
    provider: nowPlayingMoviesProvider,
    url: '${Strings.categorieRoute}nowplaying',
  ),
  CategorieItem(
    title: Strings.popular,
    provider: popularMoviesProvider,
    url: '${Strings.categorieRoute}popular',
  ),
  CategorieItem(
    title: Strings.upcoming,
    provider: upcomingMoviesProvider,
    url: '${Strings.categorieRoute}upcoming',
  ),
  CategorieItem(
    title: Strings.topRated,
    provider: topRatedMoviesProvider,
    url: '${Strings.categorieRoute}toprated',
  ),
];
