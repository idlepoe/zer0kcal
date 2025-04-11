import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zer0kcal/core/widgets/app_scaffold.dart';
import 'package:zer0kcal/core/widgets/bottom_navigation_button.dart';
import 'package:zer0kcal/features/upload/bloc/upload_bloc.dart';
import 'package:zer0kcal/features/upload/bloc/upload_event.dart';
import 'package:zer0kcal/features/upload/bloc/upload_state.dart';

import '../../../core/constants/app_colors.dart';
import '../bloc/upload_state.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadBloc, UploadState>(
      listener: (BuildContext context, UploadState state) {
        if (state is UploadInitial) {}
      },
      builder: (BuildContext context, state) {
        final isLoading = state is UploadLoading;

        return AppScaffold(
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
            isLoading: isLoading,
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
        );
      },
    );
  }
}
