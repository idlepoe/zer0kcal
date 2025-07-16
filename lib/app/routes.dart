import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zer0kcal/data_provider/ai_provider.dart';
import 'package:zer0kcal/features/feed/bloc/feed_bloc.dart';
import 'package:zer0kcal/features/result/models/calorie_result.dart';
import 'package:zer0kcal/features/result/screens/result_screen.dart';
import 'package:zer0kcal/features/upload/bloc/upload_bloc.dart';
import 'package:zer0kcal/repositories/feed_repository_impl.dart';

import '../core/dio_interceptor.dart';
import '../core/logger.dart';
import '../data_provider/firestore_provider.dart';
import '../features/feed/bloc/feed_detail_bloc.dart';
import '../features/feed/models/feed.dart';
import '../features/feed/screens/feed_detail_screen.dart';
import '../features/feed/screens/feed_screen.dart';
import '../features/result/bloc/result_bloc.dart';
import '../features/splash/screens/splash_screen.dart';
import '../features/upload/screens/upload_screen.dart';

class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/feed',
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => FeedBloc(
                    FeedRepositoryImpl(FirestoreProvider(), AiProvider()),
                  ),
              child: FeedScreen(),
            ),
      ),
      GoRoute(
        path: '/detail/:id',
        builder: (context, state) {
          logger.d(state);
          final id = state.pathParameters['id']!;
          final initialData = state.extra as Feed?; // extra에서 Feed 데이터 추출

          return BlocProvider(
            key: UniqueKey(),
            create:
                (context) => FeedDetailBloc(
                  FeedRepositoryImpl(FirestoreProvider(), AiProvider()),
                ),
            child: FeedDetailScreen(id: id, initialData: initialData),
          );
        },
      ),
      GoRoute(
        path: '/upload',
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => UploadBloc(
                    FeedRepositoryImpl(FirestoreProvider(), AiProvider()),
                  ),
              child: UploadScreen(),
            ),
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) {
          var result = CalorieResult(
            url:
                "https://firebasestorage.googleapis.com/v0/b/zer0kcal.firebasestorage.app/o/images%2F20250412083747533_1000017911.jpg?alt=media&token=285c4a69-239b-4f11-84dc-d571bd1b8da9",
            message:
                "🍞 이건 크림이 듬뿍 올라간 달콤한 와플이에요!\n겉은 바삭하고 속은 촉촉해 보이고,\n위에는 부드러운 생크림과 과일이 살짝 얹어져 있어서 보는 것만으로도 기분이 좋아져요 😊",
          );
          if (state.extra != null) {
            result = state.extra as CalorieResult;
          }
          return BlocProvider(
            create:
                (context) => ResultBloc(
                  FeedRepositoryImpl(FirestoreProvider(), AiProvider()),
                ),
            child: ResultScreen(calorieResult: result),
          );
        },
      ),
    ],
  );
}
