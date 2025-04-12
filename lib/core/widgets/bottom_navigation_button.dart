import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zer0kcal/core/widgets/app_button.dart';

import '../constants/app_colors.dart';
import 'app_inkwell.dart';

Widget BottomNavigationButton({
  required String buttonText,
  required VoidCallback onTap,
  bool isLoading = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: AppButton(
      buttonText: buttonText,
      onTap: onTap,
      isLoading: isLoading,
    ),
  );
}
