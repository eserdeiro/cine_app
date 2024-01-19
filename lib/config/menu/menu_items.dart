import 'package:cine_app/config/constants/strings.dart';
import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String url;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.url,
    required this.icon,
  });
}

List<MenuItem> appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Home',
    url: Strings.homeUrl,
    icon: Icons.home_max,
  ),
  MenuItem(
    title: 'Favorites',
    url: Strings.favoriteUrl,
    icon: Icons.favorite_border_outlined,
  ),
];
