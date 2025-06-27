import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zer0kcal/app/routes.dart';

import 'logger.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // logger.i("🚀 [REQUEST] ${options.method} ${options.uri}");

    // ✅ 요청 시작 시간 기록
    options.extra['startTime'] = DateTime.now();

    if (options.data != null) logger.d("Data: ${options.data}");

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final idToken = await user.getIdToken(true);
        if (idToken != null && idToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $idToken';
          handler.next(options);
        } else {
          logger.w("⚠️ Firebase ID Token is empty");
          _redirectToLogin();
          handler.reject(
            DioException(
              requestOptions: options,
              error: 'Empty Firebase token',
              type: DioExceptionType.cancel,
            ),
          );
        }
      } else {
        logger.w("❌ 로그인 안 된 사용자 요청 차단");
        _redirectToLogin();
        handler.reject(
          DioException(
            requestOptions: options,
            error: 'User not authenticated',
            type: DioExceptionType.cancel,
          ),
        );
      }
    } catch (e) {
      logger.e("❌ Firebase 인증 처리 중 오류: $e");
      _redirectToLogin();
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'Firebase auth token error',
          type: DioExceptionType.cancel,
        ),
      );
    }
  }

  void _redirectToLogin() {
    final context = AppRouter.navigatorKey.currentContext;
    if (context != null) {
      context.go('/login');
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final startTime = response.requestOptions.extra['startTime'] as DateTime?;
    final endTime = DateTime.now();
    final duration = startTime != null ? endTime.difference(startTime) : null;

    logger.i(
      "✨ [RESPONSE] ${response.requestOptions.method} ${response.requestOptions.uri}\n"
      "⏱ Duration: ${duration?.inMilliseconds}ms\n"
      "📝 Status: ${response.statusCode}",
    );

    if (response.data != null) logger.d("Data: ${response.data}");

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final startTime = err.requestOptions.extra['startTime'] as DateTime?;
    final endTime = DateTime.now();
    final duration = startTime != null ? endTime.difference(startTime) : null;

    logger.e(
      "❌ [ERROR] ${err.requestOptions.method} ${err.requestOptions.uri}\n"
      "⏱ Duration: ${duration?.inMilliseconds}ms\n"
      "📝 Status: ${err.response?.statusCode}\n"
      "💬 Message: ${err.message}",
    );

    if (err.response?.data != null) logger.d("Data: ${err.response?.data}");

    handler.next(err);
  }
}
