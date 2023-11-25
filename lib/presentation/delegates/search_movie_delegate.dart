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
   return FutureBuilder(future: searchMovies(query), 
                      builder: (context, snapshot) {
                      final movies = snapshot.data ?? [];
                       return ListView.builder(
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return GestureDetector(
                            onTap: () => query = movie.title,
                            child: ListTile(
                              title: Text(movie.title),
                            ),
                          );
                        },);
                      },);
  }


}