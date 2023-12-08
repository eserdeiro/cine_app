import 'dart:async';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

typedef SearchMovieCallback = Future <List<ItemEntity>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<ItemEntity?> {

  final SearchMovieCallback searchMovies;
  List<ItemEntity> initialMovies;

  StreamController<List<ItemEntity>> debouncedMovies  = StreamController.broadcast();
  StreamController<bool> isLoading  = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies 
    }): super(
     // searchFieldLabel: 'Search'
    ); 

  void clearStreams(){
    debouncedMovies.close();
  }


  void _onQueryChanged(String query) {
    isLoading.add(true);
    if(_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async{
      //This is executed when the user stops typing for 500 ms
      final movies = await searchMovies(query);
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoading.add(false);
    });
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(color: colors.background),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colors.background),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colors.background),
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
    StreamBuilder(
      stream: isLoading.stream, 
      builder: (context, snapshot) {
        if(snapshot.data ?? false) {
          return SpinPerfect(
              infinite: true,
              child: IconButton(
                  onPressed: () {
                    query = '';
                  },
                  icon: const Icon(Icons.refresh_outlined)),
            );
        } 
       return FadeIn(
              animate: query.isNotEmpty,
              child: IconButton(
                  onPressed: () {
                    query = '';
                  },
                  icon: const Icon(Icons.clear_rounded)),
            );
      },)
      
    ];
    
  }

  @override
  Widget? buildLeading(BuildContext context) {
    const bool isWeb = bool.fromEnvironment('dart.library.js_util');
    return IconButton(onPressed: () {
      clearStreams();
      close(context, null);
    }, icon: Icon(
            isWeb
            ? Icons.arrow_back_outlined  // No modifica el ícono si es Web
            : Platform.isAndroid
                ? Icons.arrow_back_outlined  // Modifica el ícono solo si no es Web y es Android
                : Icons.arrow_back_ios,  // Modifica el ícono solo si no es Web y no es Android
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
     return _buildSuggestionsAndResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
   return _buildSuggestionsAndResults();

  }

    Widget _buildSuggestionsAndResults(){
      return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      //future: searchMovies(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return _MovieItem(
          item: movies, 
          query: query,
          onMovieSelected: (context, movie){
            clearStreams();
            close(context, movie);
          });
        //TODO add similar movies
      },
    );
  }
}




class _MovieItem extends StatelessWidget {
  final List<ItemEntity> item;
  final String query;
  final Function onMovieSelected;
  const _MovieItem({
    required this.item,
    required this.query,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (item.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Main results for $query',
              style: titleStyle.titleLarge,
            ),
          ),
        Expanded(
          child: ItemsGridView(
        items: item)
        ),
      ],
    );
  }
}
