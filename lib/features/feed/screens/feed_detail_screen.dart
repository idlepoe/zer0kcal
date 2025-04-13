import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zer0kcal/core/widgets/app_button.dart';
import 'package:zer0kcal/core/widgets/app_inkwell.dart';
import 'package:zer0kcal/core/widgets/app_scaffold.dart';
import 'package:zer0kcal/core/widgets/no_data.dart';
import 'package:zer0kcal/features/feed/bloc/feed_bloc.dart';
import 'package:zer0kcal/features/feed/bloc/feed_detail_bloc.dart';
import 'package:zer0kcal/features/feed/bloc/feed_state.dart';
import 'package:zer0kcal/features/feed/widgets/feed_image.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/dio_interceptor.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/widgets/app_network_image.dart';
import '../bloc/feed_event.dart';
import '../models/comment.dart';
import '../models/feed.dart';

class FeedDetailScreen extends StatefulWidget {
  final String id;

  const FeedDetailScreen({super.key, required this.id});

  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {
  TextEditingController _tecComment = TextEditingController();
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

  final List<String> _likeMsg = [
    "와 이건 진심 내 스타일이에요!",
    "귤이 감동했어요 🍊",
    "이건 무조건 좋아요!",
    "살 안 찔 것 같아서 더 좋아요!",
    "마음이 따뜻해지는 음식이에요 ☁️",
    "나도 이거 먹고 싶어요!",
    "오늘의 제로 칼로리 픽!",
    "어머, 이건 저장각이에요!",
    "귤이도 한 입만 주세요~",
    "기분 좋아지는 음식이에요!",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<FeedDetailBloc>().add(FeedDetailFetch(feedID: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedDetailBloc, FeedState>(
      listener: (context, FeedState state) {
        if (state is FeedDetailFetchSuccess) {
          _tecComment.clear();
        }
      },
      builder: (context, FeedState state) {
        Feed? item = null;
        if (state is FeedFailure) {
          // _refreshController.refreshCompleted();
        }
        if (state is FeedDetailFetchSuccess) {
          item = state.result;
        }
        return AppScaffold(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.detailBackgroundColor,
              AppColors.resultBackColor,
            ],
          ),
          body:
              item == null
                  ? NoDataMascote(msg: "해당 피드를 찾을 수 없습니다.")
                  : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: AppNetworkImage(
                                    url: item.url,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        successMsg[Random().nextInt(
                                          successMsg.length,
                                        )],
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: 25,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset(
                                            "assets/ic_heart.png",
                                            height: 20,
                                            fit: BoxFit.fitHeight,
                                          ),
                                          Text(
                                            item.cnt_like.toString(),
                                            style: TextStyle(
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Image.asset(
                                            "assets/ic_comment.png",
                                            height: 20,
                                            fit: BoxFit.fitHeight,
                                          ),
                                          Text(
                                            item.cnt_comment.toString(),
                                            style: TextStyle(
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            AppUtils.timeAgo(item.created_at),
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/ic_detail.png",
                                height: 120,
                                fit: BoxFit.fitHeight,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  item.message,
                                  style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          AppButton(
                            buttonText:
                                _likeMsg[Random().nextInt(_likeMsg.length)],
                            onTap: () {
                              context.read<FeedDetailBloc>().add(
                                FeedLikePressed(feedID: item!.id),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            "댓글",
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 25,
                            ),
                          ),
                          Column(
                            children: List.generate(
                              item.comments.length,
                              (index) => ListTile(
                                leading: Image.asset(
                                  index % 2 == 0
                                      ? "assets/ic_orange2.png"
                                      : "assets/ic_orange1.png",
                                  height: 30,
                                  fit: BoxFit.fitHeight,
                                ),
                                title: Text(
                                  item!.comments[index].message,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                subtitle: Text(
                                  AppUtils.timeAgo(
                                    item!.comments[index].created_at,
                                  ),
                                  style: TextStyle(color: AppColors.textColor),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFDEECF), // 배경색
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: TextField(
                                        controller: _tecComment,
                                        style: TextStyle(
                                          color: Color(0xFF8A6F4D), // 글자색 (예상)
                                          fontSize: 18,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '댓글을 입력하세요',
                                          hintStyle: TextStyle(
                                            color: Color(
                                              0xFFB29A7D,
                                            ), // 힌트색 (예상)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                AppInkWell(
                                  onTap: () {
                                    final List<String> _commentMsg = [
                                      "귤이가 댓글 기다리고 있어요 🍊",
                                      "제로 칼로리 감성 한 줄만 써주세요!",
                                      "앗, 댓글이 비었어요! 살짝 눌러 담아봐요 :)",
                                      "마음속 한마디라도 남겨주시면 제로 칼로리!",
                                      "너무 맛있어서 말문이 막혔나요? 한 글자라도 좋아요!",
                                      "이 맛을 표현하고 싶은 마음... 놓치지 마세요!",
                                      "댓글 없이 제출은 아쉬워요~ 🍽️",
                                      "댓글은 사랑입니다. 한 줄 부탁해요!",
                                      "응원, 감상, 감탄 다 좋아요! 지금 바로 입력!",
                                    ];

                                    if (_tecComment.text.isEmpty) {
                                      showOkAlertDialog(
                                        context: context,
                                        message:
                                            _commentMsg[Random().nextInt(
                                              _commentMsg.length,
                                            )],
                                      );
                                      return;
                                    }
                                    Comment param = Comment.fromJson({});
                                    param = param.copyWith(
                                      feed_id: item!.id,
                                      message: _tecComment.text,
                                    );

                                    context.read<FeedDetailBloc>().add(
                                      FeedCommentPressed(comment: param),
                                    );
                                  },
                                  child: Container(
                                    height: 60,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE76B1C), // 주황색 버튼
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '제출',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
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
        );
      },
    );
  }
}
