import 'package:animate_do/animate_do.dart';
import 'package:cine_app/config/helpers/orientation_helper.dart';
import 'package:cine_app/presentation/widgets/index.dart';
import 'package:flutter/material.dart';

class BackgroundImageItem extends StatelessWidget {
  final String imagePath;

  const BackgroundImageItem({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orientationHelper = OrientationHelper(context);
    final landscape = orientationHelper.isLandscape;
    final colors = Theme.of(context).colorScheme;
    return Stack(
      children: [
        SizedBox.expand(
          child: FadeIn(
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        LayoutBuilder(
          builder: (_, __) {
            if (landscape) {
              return Stack(
                children: [
                  CustomGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 1.0],
                    colors: [Colors.transparent, colors.background],
                  ),
                  CustomGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 0.7],
                    colors: [colors.background, Colors.transparent],
                  ),
                  CustomGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: const [0.0, 0.7],
                    colors: [colors.background, Colors.transparent],
                  ),
                ],
              );
            } else {
              return Stack(
                children: [
                  CustomGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.5, 1.0],
                    colors: [Colors.transparent, colors.background],
                  ),
                  CustomGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 0.5],
                    colors: [colors.background, Colors.transparent],
                  ),
                  CustomGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: const [0.0, 0.5],
                    colors: [colors.background, Colors.transparent],
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
