import 'package:animate_do/animate_do.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BackgroundImageItem extends StatelessWidget {
   final String imagePath;

  const BackgroundImageItem({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return  Stack(
      children: [
        SizedBox.expand(
          child: Image.network(imagePath, fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) return const SizedBox();
            return FadeIn(child: child);
          }),
        ),
          CustomGradient(
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter, 
            stops: const [0.5, 1.0],
            colors: [Colors.transparent, colors.background]),

          CustomGradient(
            begin: Alignment.topLeft, 
            end: Alignment.bottomRight, 
            stops: const [0.0, 0.5],
            colors: [colors.background, Colors.transparent]),

          CustomGradient(
            begin: Alignment.topRight, 
            end: Alignment.bottomLeft, 
            stops: const [0.0, 0.5],
            colors: [colors.background, Colors.transparent]),    
      ],
    );
  }
}