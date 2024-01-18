import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/config/menu/menu_items.dart';
import 'package:cine_app/presentation/screens/error_screen.dart';
import 'package:cine_app/presentation/screens/movies/index.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  //GoException: no routes for location
  errorBuilder: (context, state) {
    return const ErrorScreen();
  },
 
  initialLocation: Strings.initialLocation,
  routes: [
     // /home/0
    GoRoute(
      path: '/',
      redirect: (_, __) {
        return Strings.initialLocation;
      },
    ),
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        //The url is not a correct index? we redirect to ErrorScreen
        final page = state.pathParameters['page'] ?? '0';
        try {
          final pageIndex = int.parse(page);
          return (pageIndex < appMenuItems.length)
              ? HomeScreen(page: pageIndex)
              : const ErrorScreen();
        } catch (e) {
          return const ErrorScreen();
        }
      },
      routes: [
        GoRoute(
          // Example /home/0/movie/46648
          path: 'movie/:id',
          name: ItemScreen.name,
          builder: (context, state) {
            final itemId = state.pathParameters['id'] ?? 'no-id';
            return ItemScreen(itemId: itemId);
          },
        ),
        GoRoute(
          // Example /home/0/categories/nowplaying
          path: 'categories/:categorie',
          name: CategorieScreen.name,
          builder: (context, state) {
            final categorieId =
                state.pathParameters['categorie'] ?? 'no-categorie';
            return CategorieScreen(categorieId: categorieId);
          },
        ),
      ],
    ),
  ],
);
