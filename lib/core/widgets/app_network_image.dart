import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

Widget AppNetworkImage({required String url, double? width, BoxFit? fit}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: CachedNetworkImage(
      imageUrl: url,
      width: width,
      fit: fit,
      progressIndicatorBuilder:
          (context, url, downloadProgress) => Center(
            child: Container(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                color: AppColors.textColor,
              ),
            ),
          ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    ),
  );
}
