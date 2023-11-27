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

    return Scaffold( 
      body: ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
         final movie = favoriteMovies[index];
          return  ListTile(
            title: Text(movie.title),
          );
        },),
    );
  }
}