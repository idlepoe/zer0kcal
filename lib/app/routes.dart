import 'package:go_router/go_router.dart';

import '../features/splash/screens/splash_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/', // 또는 '/feed' 등
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      // GoRoute(
      //   path: '/feed',
      //   builder: (context, state) => const FeedScreen(),
      // ),
      // GoRoute(
      //   path: '/upload',
      //   builder: (context, state) => const UploadScreen(),
      // ),
    ],
  );
}