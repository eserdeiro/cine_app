import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              MovieHorizontalListview(
                movies: nowPlayingMovies,
                title: Strings.movieHorizontalListviewOne,
                //TODO SET DATE
                subtitle: 'Today',
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),

              //Popular
              MovieHorizontalListview(
                movies: popularMovies,
                title: Strings.movieHorizontalListviewTwo,
                //TODO SET DATE
                subtitle: 'Today',
                loadNextPage: () {
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                },
              ),

               //Upcoming
              MovieHorizontalListview(
                movies: upcomingMovies,
                title: Strings.movieHorizontalListviewThree,
                //TODO SET DATE
                subtitle: 'Today',
                loadNextPage: () {
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                },
              ),

               //Toprated
              MovieHorizontalListview(
                movies: topRatedMovies,
                title: Strings.movieHorizontalListviewFour,
                //TODO SET DATE
                subtitle: 'Today',
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