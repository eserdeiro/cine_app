import 'package:animate_do/animate_do.dart';
import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemPoster extends StatelessWidget {
  final ItemEntity item;
  const ItemPoster({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final itemPosterPath = item.posterPath;
    final itemId = item.id;
    return SizedBox(
      child: Image.network(
        itemPosterPath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return const PosterLoadingProgress();
          } else {
            //redirect from '/movie' to '/home/0/move/id' because movie is not recognized
            return GestureDetector(
              onTap: () => context.push('${Strings.movieRoute}$itemId'),
              child: FadeIn(
                delay: const Duration(milliseconds: 200),
                child: child,
              ),
            );
          }
        },
      ),
    );
  }
}