import 'package:cine_app/config/categorie/categorie_items.dart';
import 'package:cine_app/presentation/providers/index.dart';
import 'package:cine_app/presentation/widgets/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    for (final categorieItem in categorieItems) {
      ref.read(categorieItem.provider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final initialLoading = ref.watch(firstLoadingProvider);
    if (initialLoading) return const FullScreenLoader();
    if (!kIsWeb) {
      FlutterNativeSplash.remove();
    }
    final slideshowProvider = ref.watch(moviesSlideshowProvider);

    //CustomScrollView + Slivers
    return CustomScrollView(
      slivers: [
        //Appbar
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            titlePadding: EdgeInsets.zero,
          ),
        ),
        //Content
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  ItemsSlideshow(items: slideshowProvider),
                  ...categorieItems.map((categorieItem) {
                    return Column(
                      children: [
                        TitleSubtitle(
                          title: categorieItem.title,
                        ),
                        TitleSubtitle(
                          title: 'Movies',
                          titleFontSize: 14,
                          titleFontWeight: FontWeight.w400,
                          subtitle: 'Show all',
                          subtitleFontColor: Colors.cyan,
                          onTapSubtitle: () {
                            context.push(categorieItem.url);
                          },
                        ),
                        ItemHorizontalListview(
                          items: ref.watch(categorieItem.provider),
                          loadNextPage: () {
                            ref
                                .read(categorieItem.provider.notifier)
                                .loadNextPage();
                          },
                        ),
                      ],
                    );
                  }),
                ],
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
