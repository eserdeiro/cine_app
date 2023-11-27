import 'package:cine_app/presentation/screens/views/favorite_view.dart';
import 'package:cine_app/presentation/screens/views/views.dart';
import 'package:flutter/material.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  final int page;

  const HomeScreen({super.key, required this.page});

  final viewRoutes = const<Widget>[
    HomeView(),
    Placeholder(),
    FavoriteView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: page,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex : page),
    );
  }
}
