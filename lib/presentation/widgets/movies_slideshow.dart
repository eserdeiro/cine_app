import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<ItemEntity> movies;
  const MoviesSlideshow({
    super.key,
    required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
        final size = MediaQuery.of(context).size;
    final bool landscape = size.width > 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TitleSubtitle(title: Strings.upComingMovies),
        ),
        SizedBox(
          height: 220,
          width: double.infinity,
          child: Swiper(
            viewportFraction: landscape ? 0.4 : 0.8,
            scale: landscape ? 0.4 : 0.8,
            autoplay: true,
            pagination: SwiperPagination(
              margin: const EdgeInsets.only(top: 0),
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
        ),
      ],
    );
  }
}


class _Slide extends StatelessWidget {
  final ItemEntity movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    var decorationBackground = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 15),
          )
        ]);

    return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: DecoratedBox(
          decoration: decorationBackground,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.network(
              movie.backdropPath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const PosterLoadingProgress();
                } else {
                  return FadeIn(child: child);
                }
              },
            ),
          ),
        ));
  }
}

