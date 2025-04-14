import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:zer0kcal/app/routes.dart';
import 'package:zer0kcal/app/theme.dart';
import 'package:zer0kcal/core/constants/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterWebFrame(
      builder: (context) {
        return MaterialApp.router(
          title: '제로칼로리',
          theme: AppTheme.light(),
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        );
      },
      maximumSize: Size(475.0, 812.0),
      enabled: kIsWeb,
      backgroundColor: Colors.grey.shade300,
    );
  }
}
