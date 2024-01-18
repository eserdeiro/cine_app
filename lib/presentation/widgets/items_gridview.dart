import 'package:cine_app/config/helpers/orientation_helper.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/widgets/shared/item_poster.dart';
import 'package:flutter/material.dart';

class ItemsGridView extends StatefulWidget {
  final String text;
  final List<ItemEntity> items;
  final VoidCallback? loadNextPage;

  const ItemsGridView({
    required this.items,
    super.key,
    this.loadNextPage,
    this.text = '',
  });

  @override
  State<ItemsGridView> createState() => _ItemsGridViewState();
}

class _ItemsGridViewState extends State<ItemsGridView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((scrollController.position.pixels + 100) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientationHelper = OrientationHelper(context);
    final landscape = orientationHelper.isLandscape;
    final titleStyle = Theme.of(context).textTheme;
    final items = widget.items;
    if (items.isNotEmpty) {
      return GridView.count(
        controller: scrollController,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        crossAxisCount: landscape ? 6 : 3,
        childAspectRatio: 0.7,
        children: [
          ...items.map((item) => ItemPoster(item: item)),
        ],
      );
    }
    return Center(child: Text(widget.text, style: titleStyle.titleLarge));
  }
}
