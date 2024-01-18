import 'package:flutter/material.dart';

class GenresItem extends StatelessWidget {
  final List<String> genreIds;
  const GenresItem({required this.genreIds, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        const Icon(Icons.local_movies_rounded),
        Text(
          genreIds.join(', '),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        
      ],
    );
  }
}
