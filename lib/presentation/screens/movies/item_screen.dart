import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/config/helpers/orientation_helper.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/providers/index.dart';
import 'package:cine_app/presentation/widgets/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ItemScreen extends ConsumerStatefulWidget {
  final String itemId;
  static String name = Strings.itemScreen;

  const ItemScreen({required this.itemId, super.key});

  @override
  ItemScreenState createState() => ItemScreenState();
}

class ItemScreenState extends ConsumerState<ItemScreen> {
  @override
  void initState() {
    super.initState();

    final providers = <dynamic>[
      movieDetailProvider,
      castByItemProvider,
      crewByItemProvider,
    ];

    for (final provider in providers) {
      ref.read(provider.notifier).load(widget.itemId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = ref.watch(movieDetailProvider)[widget.itemId];
    if (item == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(strokeWidth: 3)),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          CustomSliverAppBar(item: item),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _ItemDetails(item: item),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

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
              //portrait
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
                              padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
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
                                      child: Text(widget.item.overview),
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

class _ItemDetails extends ConsumerWidget {
  final ItemEntity item;

  const _ItemDetails({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final landscape = size.width > 600;
    final cast = ref.watch(castByItemProvider);
    final crew = ref.watch(crewByItemProvider);
    final castShowAll = ref.watch(castControllerProvider);
    final crewShowAll = ref.watch(crewControllerProvider);
    final castIsNotEmpty = cast.values.any((list) => list.isNotEmpty);
    final crewIsNotEmpty = crew.values.any((list) => list.isNotEmpty);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          //portrait posterpath + overview
          if (!landscape)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleSubtitle(
                  title: Strings.overview,
                  horizontalPadding: 0,
                ),
                const SizedBox(height: 8),
                Text(item.overview),
              ],
            ),

          //Actors
          //Cast view
          if (castIsNotEmpty)
            TitleSubtitle(
              title: Strings.cast,
              horizontalPadding: 0,
              subtitle: castShowAll ? Strings.hideAll : Strings.showAll,
              subtitleFontColor: Colors.cyan,
              onTapSubtitle: () {
                ref.read(castControllerProvider.notifier).toggleShowAll();
              },
            ),
          const SizedBox(height: 16),
          ActorsByItem(
            itemId: item.id.toString(),
            actorsByItem: cast,
            showAll: castShowAll,
          ),

          //Crew view
          if (crewIsNotEmpty)
            TitleSubtitle(
              title: Strings.crew,
              horizontalPadding: 0,
              subtitle: crewShowAll ? Strings.hideAll : Strings.showAll,
              subtitleFontColor: Colors.cyan,
              onTapSubtitle: () {
                ref.read(crewControllerProvider.notifier).toggleShowAll();
              },
            ),
          const SizedBox(height: 16),
          ActorsByItem(
            itemId: item.id.toString(),
            actorsByItem: crew,
            showAll: crewShowAll,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
