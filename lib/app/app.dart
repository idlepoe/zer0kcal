import 'package:flutter/material.dart';
import 'package:zer0kcal/app/routes.dart';
import 'package:zer0kcal/app/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '제로칼로리',
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
