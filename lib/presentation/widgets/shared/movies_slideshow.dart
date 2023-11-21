import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideshow({
    super.key,
    required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.7,
        scale: 0.8,
        autoplay: true,
        pagination: SwiperPagination(
          margin: EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary
          )
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _Slide(movie: movie);
        },
        ),
    );
  }
}


class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decorationBackground = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 10),
          )
        ]);

    return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: DecoratedBox(
          decoration: decorationBackground,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                movie.backdropPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const _SlideLoadingProgress();
                  } else {
                    return FadeIn(child: child);
                  }
                },
              )),
        ));
  }
}

class _SlideLoadingProgress extends StatelessWidget {
  const _SlideLoadingProgress();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black12,)),
          SpinPerfect(
            infinite: true,
            child: const Center(
              child: Icon(Icons.refresh, size: 40),
              ),
          )
      ],
    );
  }
}