import 'package:go_router/go_router.dart';
import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/presentation/screens/screens.dart';

final appRouter = GoRouter(
  // /home/0
  initialLocation: Strings.initialLocation,
  routes: [
    //redirect from '/' to '/home/0' because home is not recognized
      GoRoute(
        path: '/',
        redirect: (_, __) {
          // /home/0
         return Strings.initialLocation;
        },),
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final page = state.pathParameters['page'] ?? '0';
        return HomeScreen(page: int.parse(page));

      },
      routes: [
        //the initial slash /movie/:id is'nt needed by the parent
        GoRoute(
      path: 'movie/:id',
      name: ItemScreen.name,
      builder: (context, state) {
        final itemId = state.pathParameters['id'] ?? 'no-id';
        return  ItemScreen(itemId: itemId);
      },
        ),
      ]),
]);
