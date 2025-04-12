import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'bubble_tail_with_border_painter.dart';

Widget SpeechBubble({double width = 300, required Widget widget}) {
  return Container(
    width: width,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.brandSubColor,
            border: Border.all(color: AppColors.textColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: widget,
        ),
        Positioned(
          bottom: -9,
          left: 24,
          child: CustomPaint(
            size: const Size(20, 10),
            painter: BubbleTailWithBorderPainter(),
          ),
        ),
      ],
    ),
  );
}
