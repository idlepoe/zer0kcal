import 'package:flutter/cupertino.dart';

import '../constants/app_colors.dart';

Widget NoDataMascote() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/sad_orange.png", width: 250, fit: BoxFit.fitWidth),
        Text(
          "공유된 피드가 없습니다.",
          style: TextStyle(fontSize: 24, color: AppColors.textColor),
        ),
      ],
    ),
  );
}
