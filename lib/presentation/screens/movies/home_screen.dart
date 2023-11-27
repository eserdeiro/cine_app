import 'package:cine_app/presentation/screens/views.dart';
import 'package:flutter/material.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const name = "home-screen";
  final int page;

  const HomeScreen({super.key, required this.page});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{
  final viewRoutes = const<Widget>[
    HomeView(),
    CategorieView(),
    FavoriteView()
  ];

 late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      keepPage: true
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
     super.build(context);

      if ( pageController.hasClients ) {
      pageController.animateToPage(
        widget.page, 
        curve: Curves.easeInOut, 
        duration: const Duration( milliseconds: 250)
      );
    }

    return Scaffold(
      body: PageView(
        controller: pageController,
       // index: widget.page,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex : widget.page),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
