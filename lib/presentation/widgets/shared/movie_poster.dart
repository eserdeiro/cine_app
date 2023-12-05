import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';

class MoviePoster extends StatelessWidget {
  final Movie movie;
  const MoviePoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.network(
        movie.posterPath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return const _SlideLoadingProgress();
          } else {
            //redirect from '/movie' to '/home/0/move/id' because movie is not recognized
            return GestureDetector(
                onTap: () => context.push('${Strings.movieRoute}${movie.id}'),
                child: FadeIn(
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(milliseconds: 1500),
                  child: child,
                ));
          }
        },
      ),
    );
  }
}

class _SlideLoadingProgress extends StatelessWidget {
  const _SlideLoadingProgress();
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
          height: 222,
          color : Colors.black12,
          child : SpinPerfect(
              infinite: true,
              child: const Icon(Icons.refresh_outlined, size: 40))),
    );
  }
}