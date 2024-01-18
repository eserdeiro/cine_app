import 'package:cine_app/config/helpers/genre_helper.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/providers/genres/genres_providers.dart';
import 'package:cine_app/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemHorizontalListview extends ConsumerStatefulWidget {
  final List<ItemEntity> items;
  final VoidCallback? loadNextPage;

  const ItemHorizontalListview({
    required this.items,
    super.key,
    this.loadNextPage,
  });

  @override
  ItemHorizontalListviewState createState() => ItemHorizontalListviewState();
}

class ItemHorizontalListviewState
    extends ConsumerState<ItemHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //When you reach the end, load more items (movies & tv shows)
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: //ListView items
          ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return _Slide(item: widget.items[index]);
        },
      ),
    );
  }
}

class _Slide extends ConsumerStatefulWidget {
  final ItemEntity item;
  const _Slide({required this.item});

  @override
  _SlideState createState() => _SlideState();
}

class _SlideState extends ConsumerState<_Slide> {
  @override
  Widget build(BuildContext context) {
    final genresData = ref.watch(genresDataNotifierProvider);
    final item = widget.item;
    final itemVoteAverage = item.voteAverage;
    final itemGenreIds = item.genreIds;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Container(
          width: 150,
          height: 222,
          color: const Color(0xff252836),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image
              Stack(
                children: [
                  SizedBox(
                    height: 222,
                    child: ItemPoster(item: item),
                  ),
                  //Vote average
                  Positioned(
                    right: 10,
                    top: 10,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      child: Container(
                        color: const Color.fromRGBO(32, 28, 44, 50),
                        width: 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: VoteAvergateItem(
                            voteAverage: itemVoteAverage,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      GenreHelper.genreIdsToNames(
                        itemGenreIds,
                        genresData,
                      ),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
