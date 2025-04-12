import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zer0kcal/core/constants/app_colors.dart';

import '../../../core/widgets/app_network_image.dart';
import '../models/feed.dart';

Widget FeedImage({required Feed item}) {
  return Expanded(
    child: Stack(
      children: [
        AppNetworkImage(
          url: item.url,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          child: Container(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.resultBackColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/ic_heart.png",
                      height: 20,
                      fit: BoxFit.fitHeight,
                    ),
                    Text(item.likeCnt.toString(), style: TextStyle(color: AppColors.textColor)),
                    SizedBox(width: 5),
                    Image.asset(
                      "assets/ic_comment.png",
                      height: 20,
                      fit: BoxFit.fitHeight,
                    ),
                    Text(item.commentCnt.toString(), style: TextStyle(color: AppColors.textColor)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
