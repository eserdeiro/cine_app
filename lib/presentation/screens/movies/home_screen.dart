import 'package:cine_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _HomeView(),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
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
                title: 'Now Playing',
                //TODO SET DATE
                subtitle: 'Today',
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),

              //Popular
              MovieHorizontalListview(
                movies: popularMovies,
                title: 'Popular',
                //TODO SET DATE
                subtitle: 'Today',
                loadNextPage: () {
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                },
              ),

               //Upcoming
              MovieHorizontalListview(
                movies: upcomingMovies,
                title: 'Upcoming',
                //TODO SET DATE
                subtitle: 'Today',
                loadNextPage: () {
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                },
              ),

               //Toprated
              MovieHorizontalListview(
                movies: topRatedMovies,
                title: 'Toprated',
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
}
