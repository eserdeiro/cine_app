import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/config/menu/menu_items.dart';
import 'package:cine_app/presentation/screens/error_screen.dart';
import 'package:cine_app/presentation/screens/movies/index.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  errorBuilder: (context, state) {
    return const ErrorScreen();
  },
  // /home/0
  initialLocation: Strings.initialLocation,
  routes: [
    //redirect from '/' to '/home/0' because home is not recognized
    GoRoute(
      path: '/',
      redirect: (_, __) {
        // /home/0
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
          //Url 
          final pageIndex = int.parse(page);
          return (pageIndex < appMenuItems.length)
              ? HomeScreen(page: pageIndex)
              : const ErrorScreen();
        } catch (e) {
          return const ErrorScreen();
        }
      },
      routes: [
        //the initial slash /movie/:id is'nt needed by the parent
        GoRoute(
          path: 'movie/:id',
          name: ItemScreen.name,
          builder: (context, state) {
            final itemId = state.pathParameters['id'] ?? 'no-id';
            return ItemScreen(itemId: itemId);
          },
        ),
      ],
    ),
  ],
);
