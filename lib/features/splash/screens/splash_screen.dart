import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zer0kcal/features/splash/bloc/splash_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../data_provider/fireauth_provider.dart';
import '../../../repositories/auth_repository_impl.dart';
import '../bloc/Splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var user =
          await AuthRepositoryImpl(FireAuthProvider()).provider.loginAnon();
      if (user != null) {
        context.go('/feed');
      } else {
        showOkAlertDialog(context: context, message: "인증에 실패하였습니다.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, 0),
                radius: 1.0,
                colors: [AppColors.brandColor, AppColors.brandSubColor],
              ),
            ),
          ),
          Positioned.fill(child: Image.asset("assets/logo.png")),
        ],
      ),
    );
  }
}
