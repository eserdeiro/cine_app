import 'package:card_swiper/card_swiper.dart';
import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/config/helpers/orientation_helper.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemsSlideshow extends StatelessWidget {
  final List<ItemEntity> items;
  const ItemsSlideshow({
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final orientationHelper = OrientationHelper(context);
    final landscape = orientationHelper.isLandscape;
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
              margin: const EdgeInsets.only(top: 1),
              builder: DotSwiperPaginationBuilder(
                activeColor: colors.primary,
                color: colors.secondary,
              ),
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _Slide(item: item);
            },
          ),
        ),
      ],
    );
  }
}

class _Slide extends StatelessWidget {
  final ItemEntity item;
  const _Slide({required this.item});

  @override
  Widget build(BuildContext context) {
    final itemBackdropPath = item.backdropPath;
    final itemId = item.id;

    // final decorationBackground = BoxDecoration(
    //   borderRadius: BorderRadius.circular(20),
    //   boxShadow: const [
    //     BoxShadow(
    //       color: Colors.black26,
    //       blurRadius: 10,
    //       offset: Offset(0, 15),
    //     ),
    //   ],
    // );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: GestureDetector(
          onTap: () => context.push('${Strings.movieRoute}$itemId'),
          child: Image.network(
            itemBackdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const PosterLoadingProgress();
              } else {
                return child;
              }
            },
          ),
        ),
      ),
    );
  }
}
