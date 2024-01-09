import 'package:animate_do/animate_do.dart';
import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviePoster extends StatelessWidget {
  final ItemEntity movie;
  const MoviePoster({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.network(
        movie.posterPath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return const PosterLoadingProgress();
          } else {
            //redirect from '/movie' to '/home/0/move/id' because movie is not recognized
            return GestureDetector(
              onTap: () => context.push('${Strings.movieRoute}${movie.id}'),
              child: FadeIn(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 1100),
                child: child,
              ),
            );
          }
        },
      ),
    );
  }
}
