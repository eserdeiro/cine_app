import 'package:cine_app/config/categorie/categorie_items.dart';
import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/presentation/widgets/items_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategorieScreen extends ConsumerStatefulWidget {
  static String name = Strings.categorieScreen;
  final String categorieId;

  const CategorieScreen({required this.categorieId, super.key});

  @override
  CategorieScreenState createState() => CategorieScreenState();
}

class CategorieScreenState extends ConsumerState<CategorieScreen> {
  late CategorieItem currentCategorieItem;

  CategorieScreenState() : currentCategorieItem = categorieItems[0];

  @override
  void initState() {
    super.initState();
    currentCategorieItem = categorieItems.firstWhere(
      (item) => item.url == '${Strings.categorieRoute}${widget.categorieId}',
    );
    ref.read(currentCategorieItem.provider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(currentCategorieItem.provider);
    return Scaffold(
      appBar: AppBar(title: Text(currentCategorieItem.title)),
      body: ItemsGridView(
        items: items,
        loadNextPage: () {
          ref.read(currentCategorieItem.provider.notifier).loadNextPage();
        },
      ),
    );
  }
}
