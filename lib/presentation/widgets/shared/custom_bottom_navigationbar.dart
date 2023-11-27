import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  void onItemSelected(BuildContext context, int value){
    switch(value){
      case 0: context.go('/home/0');
      break;
      case 1: context.go('/home/1');
      break;
      case 2: context.go('/home/2');
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        onItemSelected(context, value);
      },
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
        icon: Icon(Icons.home_max),
        label: 'Home'),

         BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: 'Categories'),

        BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border_outlined),
        label: 'Favorites'),
    ]);
  }
}
