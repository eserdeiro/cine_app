import 'package:flutter/material.dart';

class ReleaseDate extends StatelessWidget {
  final DateTime? releaseDate;
  const ReleaseDate({
    required this.releaseDate, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.calendar_month),
        Text('${releaseDate!.year}'),
      ],
    );
  }
}
