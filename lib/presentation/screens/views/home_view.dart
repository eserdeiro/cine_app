import 'package:cine_app/domain/entities/genre_entity.dart';
import 'package:cine_app/infrastructure/datasources/genres_from_moviedb.dart';
import 'package:cine_app/presentation/providers/genres/genre_repository_provider.dart';
import 'package:cine_app/presentation/providers/genres/genres_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(genreRepositoryProvider);
    ref.read(genreRepositoryProvider).getGenres();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    final initialLoading = ref.watch(firstLoadingProvider);
    if(initialLoading) return const FullScreenLoader();
    //If changed to nowPlayingMovies, a list of 20 movies will be displayed
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies    = ref.watch(popularMoviesProvider);
    final upcomingMovies   = ref.watch(upcomingMoviesProvider);
    final topRatedMovies   = ref.watch(topRatedMoviesProvider);
    final slideshowProvider = ref.watch(moviesSlideshowProvider);
     final genresData = ref.watch(genresDataNotifierProvider);

    if (genresData.genres.isEmpty) {
      // Si la lista de géneros está vacía, carga los datos
      _loadGenres(context, ref);
      return CircularProgressIndicator();
    }
    //CustomScrollView + Slivers
    return CustomScrollView(
      slivers: [
        //Appbar
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            titlePadding: EdgeInsets.zero,
          ),
        ),
        //Content
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              
              MoviesSlideshow(movies: slideshowProvider),
              //NowPlaying
          TitleSubtitle(title: Strings.nowPlaying, subtitle: 'xd', subtitleFontColor: Colors.cyan),
          const TitleSubtitle(title: 'Movies', titleFontSize: 14, titleFontWeight: FontWeight.w400),
          const SizedBox(height: 10),
              ItemHorizontalListview(
                movies: nowPlayingMovies,
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),

              TitleSubtitle(title: Strings.popular, subtitle: 'xd', subtitleFontColor: Colors.cyan),
              const TitleSubtitle(title: 'Movies', titleFontSize: 14, titleFontWeight: FontWeight.w400),
              //Popular
              ItemHorizontalListview(
                movies: popularMovies,
                loadNextPage: () {
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                },
              ),
              
              TitleSubtitle(title: Strings.upcoming, subtitle: 'xd', subtitleFontColor: Colors.cyan),
              const TitleSubtitle(title: 'Movies', titleFontSize: 14, titleFontWeight: FontWeight.w400),
               //Upcoming
              ItemHorizontalListview(
                movies: upcomingMovies,
                loadNextPage: () {
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                },
              ),

              TitleSubtitle(title: Strings.topRated, subtitle: 'xd', subtitleFontColor: Colors.cyan),
              const TitleSubtitle(title: 'Movies', titleFontSize: 14, titleFontWeight: FontWeight.w400),
               //Toprated
              ItemHorizontalListview(
                movies: topRatedMovies,
                loadNextPage: () {
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                },
              ),
            ],
          );
        }, childCount: 1))
      ],
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

Future<void> _loadGenres(BuildContext context, ref) async {
    final genres = await ref.watch(genreRepositoryProvider).getGenres();
    ref.watch(genresDataNotifierProvider.notifier).setGenres(genres);
  }