import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zer0kcal/core/widgets/app_scaffold.dart';
import 'package:zer0kcal/core/widgets/bottom_navigation_button.dart';
import 'package:zer0kcal/features/upload/bloc/upload_bloc.dart';
import 'package:zer0kcal/features/upload/bloc/upload_event.dart';
import 'package:zer0kcal/features/upload/bloc/upload_state.dart';

import '../../../core/constants/app_colors.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> loadingMsg = [
      "귤이 지금 사진을 코로 킁킁 맡는 중이에요...",
      "AI가 음식의 미모에 감탄하고 있어요 🤖✨",
      "잠시만요~ 맛있어 보이는지 먼저 확인 중이에요.",
    ];

    List<String> aiLoadingMsg = [
      "이건 제로칼로리일지... 진지하게 회의 중이에요 🤔",
      "칼로리 걱정은 귤이가 맡았어요!",
      "곧 제로칼로리 인증서가 도착할 거예요 📄🍊",
    ];

    return BlocConsumer<UploadBloc, UploadState>(
      listener: (BuildContext context, UploadState state) {
        if (state is UploadInitial) {
        } else if (state is UploadSuccess) {
          context.push("/result", extra: state.result);
        } else if (state is UploadFailure) {
          showOkAlertDialog(context: context);
        }
      },
      builder: (BuildContext context, state) {
        final isLoading = state is UploadLoading;
        final isAiLoading = state is UploadAiLoading;
        return Stack(
          children: [
            AppScaffold(
              title: "업로드",
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "제로 칼로리",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "칼로리는 AI가 알아서\n'제로'로 만들어드려요.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Image.asset(
                      "assets/desc_orange.png",
                      fit: BoxFit.fitWidth,
                      width: 400,
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationButton(
                isLoading: isLoading || isAiLoading,
                buttonText: "사진 업로드",
                onTap: () async {
                  final bloc = context.read<UploadBloc>();
                  final picker = ImagePicker();
                  XFile? xFile = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (xFile != null) {
                    bloc.add(UploadPressed(xFile));
                  }
                },
              ),
            ),
            // if (isLoading || isAiLoading)
            Positioned.fill(
              child: Scaffold(
                backgroundColor: Colors.white.withAlpha(175),
                body: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/loading_orange.png",
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(height: 20),
                      isLoading
                          ? Column(
                            children: [
                              Text(
                                loadingMsg[Random().nextInt(loadingMsg.length)],
                              ),
                            ],
                          )
                          : Column(
                            children: [
                              Text(
                                "${loadingMsg[Random().nextInt(loadingMsg.length)]}(완료)",
                              ),
                              Text(
                                aiLoadingMsg[Random().nextInt(
                                  aiLoadingMsg.length,
                                )],
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
