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

const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Home',
    url: '/home/0',
    icon: Icons.home,
  ),
  MenuItem(
    title: 'Favorites',
    url: '/home/1',
    icon: Icons.favorite_border_outlined,
  ),
];
