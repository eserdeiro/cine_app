import 'package:cine_app/presentation/screens/views/index.dart';
import 'package:cine_app/presentation/widgets/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home-screen';
  final int page;

  const HomeScreen({required this.page, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{
  final viewRoutes = const[
    HomeView(),
    FavoriteView(),
  ];

 late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
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
        duration: const Duration( milliseconds: 250),
      );
    }
    
    if(kIsWeb){
          return Scaffold(
        body: IndexedStack(
          index: widget.page,
          children: viewRoutes,
        ),
        bottomNavigationBar:
            CustomBottomNavigationBar(currentIndex: widget.page),
      );
    }
    //If is mobile 
        return Scaffold(
      body: PageView(
        controller: pageController,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex : widget.page),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
