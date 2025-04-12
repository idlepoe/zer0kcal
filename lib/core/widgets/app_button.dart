import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zer0kcal/core/widgets/app_inkwell.dart';

import '../constants/app_colors.dart';

Widget AppButton({
  required String buttonText,
  required VoidCallback onTap,
  bool isLoading = false,
}) {
  return AppInkWell(
    onTap: isLoading ? null : onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.brandSubColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: isLoading
                ? CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              color: AppColors.textColor,
            )
                : Text(
              buttonText,
              style: TextStyle(
                fontSize: 24,
                color: AppColors.textColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
