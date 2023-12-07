import 'package:cine_app/config/helpers/formats.dart';
import 'package:flutter/material.dart';

class VoteAvergateItem extends StatelessWidget {
  final double voteAverage;
  const VoteAvergateItem({super.key, required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme;
    return SizedBox(
                   width: 55,
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 5),
                     child: Row(
                       children: [
                         const Icon(Icons.star, color: Color(0xfffd8701), size: 15),
                         const SizedBox(width: 2),
                         Text(Formats.number(voteAverage , 1),
                             style: titleStyle.bodyMedium
                                 ?.copyWith(color: const Color(0xfffd8701))),
                         const Spacer(),
                       ],
                     ),
                   ), 
                 );
  }
}