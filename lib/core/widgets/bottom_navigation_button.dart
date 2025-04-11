import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'app_inkwell.dart';

Widget BottomNavigationButton({
  required String buttonText,
  required VoidCallback onTap,
  bool isLoading = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: AppInkWell(
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
              child:
                  isLoading
                      ? CircularProgressIndicator()
                      : Text(
                        "업로드",
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.textColor,
                        ),
                      ),
            ),
          ],
        ),
      ),
    ),
  );
}
