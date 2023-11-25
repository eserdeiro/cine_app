import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';

class SearchMovieDelegate extends SearchDelegate<Movie?> {

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
   return const Text('buildsuggestions');
  }


}