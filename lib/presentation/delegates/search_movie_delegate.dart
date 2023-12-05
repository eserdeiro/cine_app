import 'dart:async';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';

typedef SearchMovieCallback = Future <List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMovieCallback searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies  = StreamController.broadcast();
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
    return IconButton(onPressed: () {
      clearStreams();
      close(context, null);
    }, icon: Icon(Platform.isAndroid? Icons.arrow_back_outlined : Icons.arrow_back_ios));
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
          movies: movies, 
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
