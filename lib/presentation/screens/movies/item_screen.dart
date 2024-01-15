import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/providers/index.dart';
import 'package:cine_app/presentation/providers/show_all_provider.dart';
import 'package:cine_app/presentation/widgets/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ItemScreen extends ConsumerStatefulWidget {
  final String itemId;
  static const name = 'item_screen';

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
  @override
  Widget build(BuildContext context) {
    final isFavoriteFutureProvider =
        ref.watch(isFavoriteProvider(widget.item.id));
    final size = MediaQuery.of(context).size;
    final landscape = size.width > 600;

    return SliverAppBar(
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
      expandedHeight: size.height * 0.60,
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
          builder: (context, constraints) {
            final availableHeight = constraints.biggest.height;

            return Stack(
              children: [
                BackgroundImageItem(
                  imagePath: landscape
                      ? widget.item.backdropPath
                      : widget.item.posterPath,
                ),

                //Center image
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //If the screen is very small, we eliminate the sizesbox and posterpath
                    if (availableHeight >= 270) const SizedBox(height: 60),
                    //Center posterpath
                    if (!landscape && availableHeight >= 270)
                      MainImageItem(
                        imagePath: widget.item.posterPath,
                        height: availableHeight * 0.45,
                      ),

                    const SizedBox(height: 20),

                    //ReleaseDate
                    if (widget.item.releaseDate?.year != null)
                      ReleaseDate(releaseDate: widget.item.releaseDate),

                    //Genres
                    GenresItem(genreIds: widget.item.genreIds),

                    //Vote average
                    VoteAvergateItem(voteAverage: widget.item.voteAverage),
                  ],
                ),
              ],
            );
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
    
  //final showAll = ref.watch(itemDetailsControllerProvider);
    final size = MediaQuery.of(context).size;
    final landscape = size.width > 600;
    final cast = ref.watch(castByItemProvider);
    final crew = ref.watch(crewByItemProvider);
    final castShowAll = ref.watch(castControllerProvider);
    final crewShowAll = ref.watch(crewControllerProvider);
    final castIsNotEmpty = cast.values.any((list) => list.isNotEmpty);
    final crewIsNotEmpty = crew.values.any((list) => list.isNotEmpty);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              //Landscape posterpath + overview
              if (landscape) {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: MainImageItem(
                        imagePath: item.posterPath,
                        height: 200,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            const TitleSubtitle(
                              title: 'Overview',
                              horizontalPadding: 0,
                            ),
                            const SizedBox(width: 10),
                            Text(item.overview),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                //Portrait overview without posterpath
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleSubtitle(
                      title: 'Overview',
                      horizontalPadding: 0,
                    ),
                    const SizedBox(height: 10),
                    Text(item.overview),
                  ],
                );
              }
            },
          ),

          //Actors
          //Cast view
          if (castIsNotEmpty)
            TitleSubtitle(
              title: 'Cast',
              horizontalPadding: 0,
              subtitle: castShowAll ? 'Hide all' : 'Show all',
              onTapSubtitle: () {
              ref.read(castControllerProvider.notifier).toggleShowAll();
              },
            ),
          ActorsByItem(
            itemId: item.id.toString(),
            actorsByItem: cast,
            showAll: castShowAll,
          ),

          //Crew view
          if (crewIsNotEmpty)
            TitleSubtitle(
              title: 'Crew',
              horizontalPadding: 0,
              subtitle: crewShowAll ? 'Hide all' : 'Show all', 
              onTapSubtitle: () {
               ref.read(crewControllerProvider.notifier).toggleShowAll();
              },
            ),
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
