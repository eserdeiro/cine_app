import 'package:flutter/material.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/widgets/shared/movie_poster.dart';

class ItemsGridView extends StatefulWidget {

  final List<ItemEntity> movies;
  final VoidCallback? loadNextPage;

  const ItemsGridView({super.key, required this.movies, this.loadNextPage});

  @override
  State<ItemsGridView> createState() => _ItemsGridViewState();
  
}

class _ItemsGridViewState extends State<ItemsGridView> {

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
    final bool landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final titleStyle = Theme.of(context).textTheme;
   if (widget.movies.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GridView.count(
            controller: scrollController,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            crossAxisCount: landscape ? 5 : 3,
            childAspectRatio: 0.7,
            children: [
              ...widget.movies.map((movie) => MoviePoster(movie: movie))
            ],
          ),
        ),
      ],
    );
   } 
   return Center(child: Text('No movies :(', style: titleStyle.titleLarge));
  }
}