import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zer0kcal/features/upload/bloc/upload_bloc.dart';
import 'package:zer0kcal/repositories/feed_repository.dart';
import 'package:zer0kcal/repositories/feed_repository_impl.dart';

import '../data_provider/firestore_provider.dart';
import '../features/feed/screens/feed_screen.dart';
import '../features/splash/screens/splash_screen.dart';
import '../features/upload/screens/upload_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/', // 또는 '/feed' 등
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/feed', builder: (context, state) => const FeedScreen()),
      GoRoute(
        path: '/upload',
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) =>
                      UploadBloc(FeedRepositoryImpl(FirestoreProvider())),
              child: UploadScreen(),
            ),
      ),
    ],
  );
}
