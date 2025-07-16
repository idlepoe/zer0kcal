import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final Feed? initialData; // 초기 데이터 추가

  const FeedDetailScreen({
    super.key,
    required this.id,
    this.initialData, // 초기 데이터 매개변수
  });

  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen>
    with TickerProviderStateMixin {
  TextEditingController _tecComment = TextEditingController();
  bool _hasLiked = false;

  late AnimationController _likeAnimationController;
  late Animation<double> _likeScaleAnimation;
  late Animation<double> _likeOpacityAnimation;

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

    _likeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _likeScaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _likeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _likeOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _likeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // initialData가 있으면 우선 표시하고, 백그라운드에서 상세 데이터 가져오기
      if (widget.initialData != null) {
        context.read<FeedDetailBloc>().add(
          FeedDetailFetchWithInitial(
            feedID: widget.id,
            initialData: widget.initialData!,
          ),
        );
      } else {
        // initialData가 없으면 기존 방식으로 로딩
        context.read<FeedDetailBloc>().add(FeedDetailFetch(feedID: widget.id));
      }

      _hasLiked = await context.read<FeedDetailBloc>().checkIfAlreadyLiked(
        widget.id,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    super.dispose();
  }

  Future<void> _handleLike(String feedId) async {
    context.read<FeedDetailBloc>().add(FeedLikePressed(feedID: feedId));
  }

  Future<void> _handleComment(Feed item) async {
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
        message: _commentMsg[Random().nextInt(_commentMsg.length)],
      );
      return;
    }

    Comment param = Comment.fromJson({});
    param = param.copyWith(feed_id: item.id, message: _tecComment.text);

    context.read<FeedDetailBloc>().add(FeedCommentPressed(comment: param));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedDetailBloc, FeedState>(
      listener: (context, FeedState state) {
        if (state is FeedDetailFetchSuccess) {
          _tecComment.clear();
        } else if (state is FeedLikeAnimating) {
          // 애니메이션 시작
          _likeAnimationController.forward().then((_) {
            setState(() {
              _hasLiked = true;
            });
            context.read<FeedDetailBloc>().add(
              FeedLikeCompleted(feedID: state.feedID),
            );
          });
        }
      },
      builder: (context, FeedState state) {
        bool _isMainLoading = false;
        bool _isLikeLoading = false;
        bool _isCommentLoading = false;
        bool _isRefreshing = false;
        Feed? item = null;

        if (state is FeedFailure) {
          // Handle failure
        } else if (state is FeedDetailFetchSuccess) {
          item = state.result;
        } else if (state is FeedDetailWithInitial) {
          item = state.result;
          _isRefreshing = state.isRefreshing;
        } else if (state is FeedLoading) {
          _isMainLoading = true;
        } else if (state is FeedLikeLoading) {
          item = state.result;
          _isLikeLoading = true;
        } else if (state is FeedCommentLoading) {
          item = state.result;
          _isCommentLoading = true;
        } else if (state is FeedLikeAnimating) {
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
              _isMainLoading
                  ? Center(
                    child: Container(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                        color: AppColors.textColor,
                      ),
                    ),
                  )
                  : item == null
                  ? NoDataMascote(msg: "해당 피드를 찾을 수 없습니다.")
                  : Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (_) => Dialog(
                                                  backgroundColor: Colors.black,
                                                  child: InteractiveViewer(
                                                    child: AppNetworkImage(
                                                      url: item!.url,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                          );
                                        },
                                        child: Stack(
                                          children: [
                                            AppNetworkImage(
                                              url: item.url,
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              bottom: 8,
                                              right: 8,
                                              child: Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.black54,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Icon(
                                                  Icons.zoom_in,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
                                AppUtils.timeAgo(item.updated_at),
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
                              if (!_hasLiked)
                                AnimatedBuilder(
                                  animation: _likeAnimationController,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _likeScaleAnimation.value,
                                      child: Opacity(
                                        opacity: _likeOpacityAnimation.value,
                                        child: Stack(
                                          children: [
                                            AppButton(
                                              buttonText:
                                                  _isLikeLoading
                                                      ? "좋아요 처리중..."
                                                      : _likeMsg[Random()
                                                          .nextInt(
                                                            _likeMsg.length,
                                                          )],
                                              onTap:
                                                  _isLikeLoading
                                                      ? () {}
                                                      : () =>
                                                          _handleLike(item!.id),
                                            ),
                                            if (_isLikeLoading)
                                              Positioned.fill(
                                                child: Center(
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    margin: EdgeInsets.only(
                                                      right: 8,
                                                    ),
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                            Color
                                                          >(Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
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
                              if (item?.comments != null &&
                                  item!.comments!.isNotEmpty)
                                Column(
                                  children: List.generate(
                                    item.comments?.length ?? 0,
                                    (index) => ListTile(
                                      leading: Image.asset(
                                        index % 2 == 0
                                            ? "assets/ic_orange2.png"
                                            : "assets/ic_orange1.png",
                                        height: 30,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      title: Text(
                                        item!.comments[index].message ?? '',
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                      subtitle: Text(
                                        AppUtils.timeAgo(
                                          item!.comments![index].created_at ??
                                              DateTime.now(),
                                        ),
                                        style: TextStyle(
                                          color: AppColors.textColor
                                              .withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _tecComment,
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "댓글을 입력하세요...",
                                        hintStyle: TextStyle(
                                          color: AppColors.textColor
                                              .withOpacity(0.5),
                                          fontSize: 15,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: AppColors.textColor
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: AppColors.textColor
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Stack(
                                    children: [
                                      AppButton(
                                        buttonText:
                                            _isCommentLoading ? "제출중..." : "제출",
                                        onTap:
                                            _isCommentLoading
                                                ? () {}
                                                : () => _handleComment(item!),
                                      ),
                                      if (_isCommentLoading)
                                        Positioned.fill(
                                          child: Center(
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              margin: EdgeInsets.only(right: 8),
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                      Color
                                                    >(Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      // 백그라운드 로딩 표시
                      if (_isRefreshing)
                        Positioned(
                          top: 20,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '댓글 로딩 중...',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'BMEULJIROTTF',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
        );
      },
    );
  }
}
