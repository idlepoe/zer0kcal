import 'package:flutter/cupertino.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_network_image.dart';
import '../models/feed.dart';
import 'feed_image.dart';

Widget buildFeedCardWithMascote(Feed item, int index) {
  Widget imgWidget = Expanded(
    child: Container(child: Column(children: [FeedImage(item: item)])),
  );
  Widget descWidget = Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment:
          index % 4 == 0 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Image.asset(
          index % 4 == 0 ? "assets/ic_orange1.png" : "assets/ic_orange2.png",
          height: 70,
          fit: BoxFit.fitHeight,
        ),
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

  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
    padding: const EdgeInsets.all(8),
    child: IntrinsicHeight(
      child: Row(
        children:
            index % 4 == 0
                ? [imgWidget, SizedBox(width: 10), descWidget]
                : [descWidget, SizedBox(width: 10), imgWidget],
      ),
    ),
  );
}
