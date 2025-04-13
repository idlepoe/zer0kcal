import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:zer0kcal/core/widgets/app_inkwell.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/dio_interceptor.dart';
import '../models/feed.dart';
import 'feed_image.dart';

Widget buildFeedCard(Feed item, int index, {required Function(Feed) onTap}) {
  return AppInkWell(
    onTap: () {
      onTap(item);
    },
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          FeedImage(item: item),
          const SizedBox(height: 8),
          Text(
            item.message,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    ),
  );
}
