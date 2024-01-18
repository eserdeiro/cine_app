import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class MainImageItem extends StatelessWidget {
  final String imagePath;
  final double height;
  const MainImageItem({
    required this.imagePath,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: SizedBox(
        child: FadeIn(
          child: Image.network(
            imagePath,
            height: height,
          ),
        ),
      ),
    );
  }
}
