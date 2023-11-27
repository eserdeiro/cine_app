import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:cine_app/presentation/widgets/shared/movie_poster_link.dart';
import 'package:flutter/material.dart';

class MoviesGridView extends StatefulWidget {

  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MoviesGridView({super.key, required this.movies, this.loadNextPage});

  @override
  State<MoviesGridView> createState() => _MoviesGridViewState();
  
}

class _MoviesGridViewState extends State<MoviesGridView> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;
      if((scrollController.position.pixels + 100) >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });

  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.movies.isNotEmpty)
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Main results for ',
            ),
          ),
        Expanded(
          child: GridView.count(
            controller: scrollController,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            children: [
              ...widget.movies.map((movie) => MoviePosterLink(movie: movie))
            ],
          ),
        ),
      ],
    );
  }
}