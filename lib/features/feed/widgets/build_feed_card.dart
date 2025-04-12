import 'package:flutter/cupertino.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_network_image.dart';
import '../models/feed.dart';

Widget buildFeedCard(Feed item, int index) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AppNetworkImage(
              url: item.url,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.result,
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