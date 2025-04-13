import 'package:flutter/cupertino.dart';

import '../constants/app_colors.dart';

Widget NoDataMascote({String msg = "공유된 피드가 없습니다."}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/sad_orange.png", width: 250, fit: BoxFit.fitWidth),
        Text(msg, style: TextStyle(fontSize: 24, color: AppColors.textColor)),
      ],
    ),
  );
}
