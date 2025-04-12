import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Gradient? gradient;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.bottomNavigationBar,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:
            gradient ??
                LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.brandColor,
                    AppColors.resultBackColor,
                    AppColors.brandColor,
                  ],
                ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading:
                ModalRoute.of(context)!.canPop
                    ? IconButton(
                      icon: Image.asset(
                        'assets/back_arrow.png',
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                    : null,
            title:
                title != null
                    ? Text(
                      title!,
                      style: TextStyle(color: AppColors.brandSubColor),
                    )
                    : null,
          ),
          body: Container(width: double.infinity, child: body),
          bottomNavigationBar: bottomNavigationBar,
        ),
      ),
    );
  }
}
