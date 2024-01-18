import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/domain/entities/index.dart';
import 'package:cine_app/presentation/providers/index.dart';
import 'package:cine_app/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          CastCrewWidget(
            title: Strings.cast,
            isNotEmpty: castIsNotEmpty,
            showAll: castShowAll,
            actorsByItem: cast,
            itemId: item.id.toString(),
            onTapSubtitle: () {
              ref.read(castControllerProvider.notifier).toggleShowAll();
            },
          ),
          const SizedBox(height: 16),

          CastCrewWidget(
            title: Strings.crew,
            isNotEmpty: crewIsNotEmpty,
            showAll: crewShowAll,
            actorsByItem: crew,
            itemId: item.id.toString(),
            onTapSubtitle: () {
              ref.read(crewControllerProvider.notifier).toggleShowAll();
            },
          ),
        ],
      ),
    );
  }
}

class CastCrewWidget extends StatelessWidget {
  final String title;
  final bool isNotEmpty;
  final bool showAll;
  final String itemId;
  final Map<String, List<ActorEntity>> actorsByItem;
  final dynamic Function() onTapSubtitle;

  const CastCrewWidget({
    required this.title,
    required this.isNotEmpty,
    required this.showAll,
    required this.actorsByItem,
    required this.onTapSubtitle,
    required this.itemId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isNotEmpty)
          TitleSubtitle(
            title: title,
            horizontalPadding: 0,
            subtitle: showAll ? Strings.hideAll : Strings.showAll,
            subtitleFontColor: Colors.cyan,
            onTapSubtitle: onTapSubtitle,
          ),
        const SizedBox(height: 16),
        ActorsByItem(
          itemId: itemId,
          actorsByItem: actorsByItem,
          showAll: showAll,
        ),
      ],
    );
  }
}
