import 'package:animate_do/animate_do.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  FavoriteViewState createState() => FavoriteViewState();
}

class FavoriteViewState extends ConsumerState<FavoriteView> {

    @override
    void initState() {
      super.initState();
     ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    }

  @override
  Widget build(BuildContext context) {

    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();
    final titleStyle = Theme.of(context).textTheme;
      return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Expanded(
            child: GridView.count(
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              children: [
                ...favoriteMovies.map((movie) => SizedBox(
                        child: FadeIn(
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 1500),
                      child: GestureDetector(
                        onTap: () {
                          //onMovieSelected(context, movie);
                        },
                        child: Image.network(movie.posterPath, fit: BoxFit.cover),
                      ),
                    )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}