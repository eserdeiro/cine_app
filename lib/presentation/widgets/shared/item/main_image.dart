import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class MainImageItem extends StatelessWidget {
  final String imagePath;
  final double height;
  const MainImageItem({
    super.key,
    required this.imagePath, required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: SizedBox.fromSize(
        child: Image.network(imagePath, height: height,
            //fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) return const SizedBox();
          return FadeIn(child: child);
        }),
      ),
    );
  }
}