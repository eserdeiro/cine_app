import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/presentation/providers/index.dart';
import 'package:cine_app/presentation/widgets/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    final providers = [
      nowPlayingMoviesProvider,
      popularMoviesProvider,
      upcomingMoviesProvider,
      topRatedMoviesProvider,
    ];

    for (final provider in providers) {
      ref.read(provider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final initialLoading = ref.watch(firstLoadingProvider);
    if (initialLoading) return const FullScreenLoader();
    if (!kIsWeb) {
      FlutterNativeSplash.remove();
    }
    //If changed to nowPlayingMovies, a list of 20 movies will be displayed
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final slideshowProvider = ref.watch(moviesSlideshowProvider);

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
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  MoviesSlideshow(movies: slideshowProvider),

                  //NowPlaying
                  TitleSubtitle(
                    title: Strings.nowPlaying,
                    subtitle: 'Today',
                    subtitleFontColor: Colors.cyan,
                  ),
                  const TitleSubtitle(
                    title: 'Movies',
                    titleFontSize: 14,
                    titleFontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 10),
                  ItemHorizontalListview(
                    movies: nowPlayingMovies,
                    loadNextPage: () {
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    },
                  ),

                  //Popular
                  TitleSubtitle(
                    title: Strings.popular,
                    subtitle: 'Today',
                    subtitleFontColor: Colors.cyan,
                  ),
                  const TitleSubtitle(
                    title: 'Movies',
                    titleFontSize: 14,
                    titleFontWeight: FontWeight.w400,
                  ),

                  ItemHorizontalListview(
                    movies: popularMovies,
                    loadNextPage: () {
                      ref.read(popularMoviesProvider.notifier).loadNextPage();
                    },
                  ),

                  //Upcoming
                  TitleSubtitle(
                    title: Strings.upcoming,
                    subtitle: 'Today',
                    subtitleFontColor: Colors.cyan,
                  ),
                  const TitleSubtitle(
                    title: 'Movies',
                    titleFontSize: 14,
                    titleFontWeight: FontWeight.w400,
                  ),

                  ItemHorizontalListview(
                    movies: upcomingMovies,
                    loadNextPage: () {
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                    },
                  ),

                  //Toprated
                  TitleSubtitle(
                    title: Strings.topRated,
                    subtitle: 'Today',
                    subtitleFontColor: Colors.cyan,
                  ),
                  const TitleSubtitle(
                    title: 'Movies',
                    titleFontSize: 14,
                    titleFontWeight: FontWeight.w400,
                  ),

                  ItemHorizontalListview(
                    movies: topRatedMovies,
                    loadNextPage: () {
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
