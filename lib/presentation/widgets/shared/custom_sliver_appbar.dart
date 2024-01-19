import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/config/helpers/orientation_helper.dart';
import 'package:cine_app/domain/entities/index.dart';
import 'package:cine_app/presentation/providers/index.dart';
import 'package:cine_app/presentation/widgets/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomSliverAppBar extends ConsumerStatefulWidget {
  final ItemEntity item;
  const CustomSliverAppBar({required this.item, super.key});

  @override
  CustomSliverAppBarState createState() => CustomSliverAppBarState();
}

class CustomSliverAppBarState extends ConsumerState<CustomSliverAppBar> {
  GlobalKey appBarKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final isFavoriteFutureProvider =
        ref.watch(isFavoriteProvider(widget.item.id));
    final size = MediaQuery.of(context).size;
    final orientationHelper = OrientationHelper(context);
    final landscape = orientationHelper.isLandscape;

    return SliverAppBar(
      key: appBarKey,
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(
          kIsWeb
              ? Icons.arrow_back_outlined
              : Platform.isAndroid
                  ? Icons.arrow_back_outlined
                  : Icons.arrow_back_ios,
        ),
      ),
      centerTitle: true,
      title: Text(widget.item.title),
      expandedHeight: size.height * 0.7,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            await ref
                .read(favoriteItemsProvider.notifier)
                .toggleFavorite(widget.item);

            ref.invalidate(isFavoriteProvider(widget.item.id));
          },
          icon: isFavoriteFutureProvider.when(
            data: (isFavorite) {
              return isFavorite
                  ? const Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.red,
                    )
                  : const Icon(Icons.favorite_border_outlined);
            },
            error: (_, __) => const Icon(Icons.cancel_outlined),
            loading: () =>
                SpinPerfect(child: const Icon(Icons.refresh_outlined)),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: LayoutBuilder(
          builder: (_, constraints) {
            final availableHeight = constraints.biggest.height;
            if (!landscape && availableHeight >= 270) {
              //Portrait
              return Stack(
                children: [
                  BackgroundImageItem(
                    imagePath: widget.item.posterPath,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      MainImageItem(
                        imagePath: widget.item.posterPath,
                        height: availableHeight * 0.45,
                      ),

                      const SizedBox(height: 16),
                      
                      if (widget.item.releaseDate?.year != null)
                      ReleaseDate(releaseDate: widget.item.releaseDate),
                      GenresItem(genreIds: widget.item.genreIds),
                      VoteAvergateItem(voteAverage: widget.item.voteAverage),
                    ],
                  ),
                ],
              );
            } else {
              //Landscape
              return Stack(
                children: [
                  BackgroundImageItem(
                    imagePath: widget.item.backdropPath,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      SafeArea(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: MainImageItem(
                                imagePath: widget.item.posterPath,
                                height: availableHeight * 0.6,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleSubtitle(
                                    title: Strings.overview,
                                    horizontalPadding: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: SizedBox(
                                      width: size.width * 0.6,
                                      child: Text(widget.item.overview, maxLines: 8,),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ReleaseDate(releaseDate: widget.item.releaseDate),
                          const SizedBox(
                            width: 8,
                          ),
                          GenresItem(genreIds: widget.item.genreIds),
                          const SizedBox(
                            width: 8,
                          ),
                          VoteAvergateItem(
                            voteAverage: widget.item.voteAverage,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
