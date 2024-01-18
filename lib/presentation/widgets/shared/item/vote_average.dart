import 'package:cine_app/config/helpers/formats_helper.dart';
import 'package:flutter/material.dart';

class VoteAvergateItem extends StatelessWidget {
  final double voteAverage;
  const VoteAvergateItem({required this.voteAverage, super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.star, color: Color(0xfffd8701), size: 16),
        const SizedBox(width: 4),
        Text(
          FormatsHelper.number(voteAverage, 1),
          style: titleStyle.bodyMedium?.copyWith(
            color: const Color(0xfffd8701),
          ),
        ),
      ],
    );
  }
}
