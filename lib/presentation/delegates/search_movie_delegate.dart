import 'package:flutter/material.dart';

class SearchMovieDelegate extends SearchDelegate {

  // @override
  // String get searchFieldLabel => 'Search';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      const Text('BuildActions'),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const Text('BuildLeading');
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