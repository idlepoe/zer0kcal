import 'package:flutter/cupertino.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_network_image.dart';
import '../models/feed.dart';
import 'feed_image.dart';

Widget buildFeedCard(Feed item, int index) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        FeedImage(item:item),
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
  );
}