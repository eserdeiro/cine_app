import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/delegates/search_movie_delegate.dart';
import 'package:cine_app/presentation/providers/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: ColoredBox(
        color: colors.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: Row(
              children: [
                if (kIsWeb) const Padding(padding: EdgeInsets.only(left: 45)),
                Icon(Icons.movie_outlined, color: colors.primary),
                const SizedBox(width: 5),
                Text(Strings.appName, style: titleStyle),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    final searchedMovies = ref.read(searchedMoviesProvider);
                    final searchQuery = ref.read(searchMoviesQueryProvider);
                    showSearch<ItemEntity?>(
                      query: searchQuery,
                      context: context,
                      delegate: SearchMovieDelegate(
                        initialMovies: searchedMovies,
                        searchMovies: ref
                            .read(searchedMoviesProvider.notifier)
                            .searchMoviesByQuery,
                      ),
                    ).then((item) {
                      if (item != null) {
                        //redirect from '/movie' to '/home/0/movie/id' because movie is not recognized
                        context.push('${Strings.movieRoute}${item.id}');
                      }
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
