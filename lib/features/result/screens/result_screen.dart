import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zer0kcal/core/widgets/app_button.dart';
import 'package:zer0kcal/core/widgets/app_inkwell.dart';
import 'package:zer0kcal/features/result/bloc/result_event.dart';
import 'package:zer0kcal/features/result/models/calorie_result.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/logger.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../bloc/result_state.dart';
import '../bloc/result_bloc.dart';

class ResultScreen extends StatelessWidget {
  final CalorieResult calorieResult;

  ResultScreen({super.key, required this.calorieResult});

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final List<String> successMsg = [
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
    final List<String> failMsg = [
      "이건… 너무 예술작품 같아서 칼로리를 셀 수가 없어요!",
      "귤이는 이걸 음식이라고 생각하지 않았어요… 🍊🤔",
      "먹을 수 있긴 한 건가요...? AI도 헷갈려요!",
      "앗! 이건 칼로리보다 감동이 먼저 와버렸어요.",
      "제로칼로리 판결 불가! 이건 먹는 게 아닌 것 같아요 😅",
      "이건… 귤이도 처음 보는 신비한 물건이에요.",
      "음식 사진이 아닌 것 같아요! 그래도 귀여우니까 0칼로리 인정?",
      "AI가 너무 당황해서 칼로리를 놓쳤어요. 다시 시도해볼까요?",
    ];
    return BlocConsumer<ResultBloc, ResultState>(
      listener: (context, ResultState state) async {
        if (state is ResultInitial) {
        } else if (state is ResultShareLoading) {
          final result = await Share.shareXFiles([
            state.xFile,
          ], text: state.calorieResult.message);
        } else if (state is ResultShareSuccess) {
        } else if (state is ResultSuccess) {
          List<String> msgList = [
            "맛있는 순간이 모두와 공유되었어요! 🍊✨",
            "제로칼로리 인증 완료! 피드에 무사히 착륙했어요 ☁️",
            "이 감동적인 제로칼로리, 이제 모두가 볼 수 있어요 😊",
          ];
          await showOkAlertDialog(
            context: context,
            message: msgList[Random().nextInt(msgList.length)],
          );
          context.pop(true);
          context.pop(true);
        } else if (state is ResultFailure) {
          showOkAlertDialog(context: context, message: state.message);
        }
      },
      builder: (context, ResultState state) {
        bool isLoading = state is ResultShareLoading;
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
                  child: Container(
                    color: isLoading ? AppColors.brandSubColor : null,
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            successMsg[Random().nextInt(successMsg.length)],
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
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: AppNetworkImage(url: calorieResult.url),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/result_orange.png',
                                width: 150,
                              ),
                              Expanded(
                                child: Text(
                                  calorieResult.message,
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      buttonText: "공유하기",
                      onTap: () async {
                        final captured = await screenshotController.capture();
                        if (captured == null) throw Exception("스크린샷 실패");
                        final xFile = await AppUtils.uint8ListToXFile(captured);
                        context.read<ResultBloc>().add(
                          ResultSharePressed(
                            xFile: xFile,
                            calorieResult: calorieResult,
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 10),
                    AppButton(
                      buttonText: "피드에 올리기",
                      onTap: () {
                        context.read<ResultBloc>().add(
                          ResultUploadFeedPressed(calorieResult: calorieResult),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                AppInkWell(
                  onTap: () {},
                  child: Image.asset(
                    "assets/recommend_app_orange.png",
                    height: 150,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
