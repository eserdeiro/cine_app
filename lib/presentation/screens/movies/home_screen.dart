
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
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
    
  }

  @override
  Widget build(BuildContext context) {
    //If changed to nowPlayingMovies, a list of 20 movies will be displayed
    //final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideshowProvider = ref.watch(moviesSlideshowProvider);
    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlideshow(movies: slideshowProvider)
      ],
    );
  }
}