import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class PosterLoadingProgress extends StatelessWidget {
  const PosterLoadingProgress({super.key});
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: ColoredBox(
        color: Colors.black12,
        child: SpinPerfect(
          infinite: true,
          child: const Icon(Icons.refresh_outlined, size: 40),
        ),
      ),
    );
  }
}
