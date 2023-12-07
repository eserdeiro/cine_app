import 'package:flutter/material.dart';

class GenresItem extends StatelessWidget {
  final List<String> genreIds;
  const GenresItem({super.key, required this.genreIds});

  @override
  Widget build(BuildContext context) {
    return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.local_movies_rounded),
                  ...genreIds.map((genreIds) {
                    return Text("$genreIds ");
                  }),
                  ],
                 );
  }
}