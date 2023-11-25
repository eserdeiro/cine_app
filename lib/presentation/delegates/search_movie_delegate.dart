import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';


typedef SearchMovieCallback = Future <List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMovieCallback searchMovies;

  SearchMovieDelegate({required this.searchMovies});

  // @override
  // String get searchFieldLabel => 'Search';

  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(onPressed: () {
          query = '';
        }, icon: const Icon(Icons.clear_rounded)),
      )
    ];
    
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: Icon(Platform.isAndroid? Icons.arrow_back_outlined : Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return _MovieItem(
          movies: movies, 
          query: query, 
          onMovieSelected: close);
        //TODO add similar movies
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final List<Movie> movies;
  final String query;
  final Function onMovieSelected;
  const _MovieItem({
    required this.movies,
    required this.query,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (movies.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Main results for $query',
              style: titleStyle.titleLarge,
            ),
          ),
        Expanded(
          child: GridView.count(
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            children: [
              ...movies.map((movie) => SizedBox(
                      child: FadeIn(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 1500),
                    child: GestureDetector(
                      onTap: () {
                        onMovieSelected(context, movie);
                      },
                      child: Image.network(movie.posterPath, fit: BoxFit.cover),
                    ),
                  )))
            ],
          ),
        ),
      ],
    );
  }
}
