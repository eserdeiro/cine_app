import 'package:cine_app/config/menu/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationBar({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        // onItemSelected(context, value);
        final menuItem = appMenuItems[value];
        context.go(menuItem.url);
      },
      elevation: 0,
      items: [
        ...appMenuItems.map(
          (item) => BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.title,
          ),
        ),
      ],
    );
  }
}
