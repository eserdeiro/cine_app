import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  FavoriteViewState createState() => FavoriteViewState();
}

class FavoriteViewState extends ConsumerState<FavoriteView> with AutomaticKeepAliveClientMixin{

    bool isLastPage = false;
    bool isLoading = false;

    @override
    void initState() {
      super.initState();
     loadNextPage();
    }

  void loadNextPage() async{
    if(isLoading || isLastPage) return;
    isLoading = true; 

    final movies = await ref.read(favoriteItemsProvider.notifier).loadNextPage();
    isLoading = false;

    if(movies.isEmpty){
      isLastPage = true;

    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final favoriteMovies = ref.watch(favoriteItemsProvider).values.toList();

    return Scaffold( 
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ItemsGridView(
        items: favoriteMovies,
        loadNextPage: loadNextPage,
        text: 'No movies :(')
    );
  }
  

  @override
  bool get wantKeepAlive => true;
}