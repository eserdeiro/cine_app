import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';

class MoviePosterLink extends StatelessWidget {
  final Movie movie;
  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: FadeIn(
      delay: const Duration(milliseconds: 500),
      duration: const Duration(milliseconds: 1500),
      child: GestureDetector(
        onTap: () {
          context.push("${Strings.movieRoute}${movie.id}");
        },
        child: Image.network(movie.posterPath, fit: BoxFit.cover),
      ),
    ));
  }
}
