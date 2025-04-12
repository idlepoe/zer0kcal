import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zer0kcal/core/widgets/app_button.dart';
import 'package:zer0kcal/core/widgets/app_inkwell.dart';
import 'package:zer0kcal/features/result/models/calorie_result.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/logger.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/widgets/app_scaffold.dart';

class ResultScreen extends StatelessWidget {
  final CalorieResult calorieResult;

  ResultScreen({super.key, required this.calorieResult});

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final List<String> messages = [
      "어머, 이건 제로칼로리야!",
      "기분 좋게 먹으면 칼로리는 0이지~",
      "맛있게 먹는 건 죄가 아니야, 칼로리도 아니야!",
      "행복하게 먹으면 0칼로리 법칙 적용 완료!",
      "이건 먹는 순간 사라지는 마법의 칼로리야 ✨",
      "이 정도는... 칼로리계도 못 봐!",
      "걱정 마! 귤이가 제로로 만들어뒀어 🍊",
      "이건 애정이 가득해서 칼로리도 녹아내렸어 ☁️",
      "칼로리? 방금 도망갔어~",
      "AI가 분석해봤는데... 0이래요. 안심하고 먹어요!",
    ];
    return AppScaffold(
      title: "제로 칼로리 판결!",
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.brandColor,
          AppColors.resultBackColor,
          AppColors.brandColor,
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Screenshot(
              controller: screenshotController,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      messages[Random().nextInt(messages.length)],
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: calorieResult.url,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Image.asset('assets/result_orange.png', width: 150),
                        Expanded(
                          child: Text(
                            calorieResult.result,
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  buttonText: "공유하기",
                  onTap: () {
                    screenshotController
                        .capture()
                        .then((var image) async {
                          XFile xFile = await AppUtils.uint8ListToXFile(image!);
                          final result = await Share.shareXFiles([
                            xFile,
                          ], text: calorieResult.result);

                          if (result.status == ShareResultStatus.success) {
                            print('Thank you for sharing the picture!');
                          }
                        })
                        .catchError((onError) {
                          print(onError);
                        });
                  },
                ),
                SizedBox(width: 10),
                AppButton(buttonText: "피드에 올리기", onTap: () {}),
              ],
            ),
            SizedBox(height: 20),
            AppInkWell(
              onTap: () {

              },
              child: Image.asset(
                "assets/recommend_app_orange.png",
                height: 200,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
