import 'package:flutter/material.dart';

class GenresItem extends StatelessWidget {
  final List<String> genreIds;
  const GenresItem({required this.genreIds, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.local_movies_rounded),
          ...genreIds.map((genreIds) {
            return Text(
              '$genreIds ',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          }),
        ],
      ),
    );
  }
}
