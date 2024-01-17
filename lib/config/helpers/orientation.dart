import 'package:flutter/material.dart';

class OrientationHelper {
  final Size size;

  OrientationHelper(BuildContext context)
      : size = MediaQuery.of(context).size;

  bool get isLandscape => size.width > 600;
}
