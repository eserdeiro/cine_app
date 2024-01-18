import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/domain/entities/item_entity.dart';
import 'package:cine_app/presentation/delegates/search_movie_delegate.dart';
import 'package:cine_app/presentation/providers/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                if (kIsWeb) const Padding(padding: EdgeInsets.only(left: 48)),
                Icon(Icons.movie_outlined, color: colors.primary),
                const SizedBox(width: 4),
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
                    );
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
