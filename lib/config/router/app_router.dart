import 'package:cine_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    
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
      name: MovieScreen.name,
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? 'no-id';
        return  MovieScreen(movieId: movieId);
      },
        ),
      ]),
      //redirect from '/' to '/home/0' because home is not recognized
      GoRoute(
        path: '/',
        redirect: (_, __) {
         return '/home/0';
        },)
]);
