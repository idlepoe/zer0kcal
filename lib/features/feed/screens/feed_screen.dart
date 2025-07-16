import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:zer0kcal/core/constants/app_colors.dart';
import 'package:zer0kcal/core/widgets/app_scaffold.dart';
import 'package:zer0kcal/core/widgets/app_inkwell.dart';
import 'package:zer0kcal/features/feed/bloc/feed_bloc.dart';
import 'package:zer0kcal/features/feed/bloc/feed_state.dart';
import 'package:zer0kcal/features/feed/bloc/feed_event.dart';
import 'package:zer0kcal/features/feed/widgets/app_refresh_header.dart';
import 'package:zer0kcal/features/feed/widgets/build_staggered_feed_tiles.dart';
import 'package:zer0kcal/core/widgets/no_data.dart';
import 'package:zer0kcal/core/widgets/ad_fit_banner_view.dart';
import 'package:zer0kcal/core/logger.dart';
import 'package:zer0kcal/features/feed/models/feed.dart';

class FeedScreen extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) async {
        if (state is FeedUploadRequested) {
          var result = await context.push("/upload");
          await Future.delayed(const Duration(seconds: 2));
          context.read<FeedBloc>().add(FeedRefresh());
        } else if (state is FeedFailure) {
          // TODO: Show error dialog
        }
      },
      builder: (context, state) {
        return AppScaffold(
          title: "공유피드",
          actions: [
            AppInkWell(
              onTap: () async {
                context.read<FeedBloc>().add(FeedUploadPressed());
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset("assets/ic_upload_feed.png"),
              ),
            ),
          ],
          body: Column(
            children: [
              Expanded(
                child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () {
                    context.read<FeedBloc>().add(FeedRefresh());
                    _refreshController.refreshCompleted();
                  },
                  header: AppRefreshHeader(),
                  child: _buildFeedContent(context, state),
                ),
              ),
              // if (!kIsWeb) ...[
              //   AdFitBannerView(adUnitId: "DAN-JzkcCXfupKSHOCca"),
              // ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeedContent(BuildContext context, FeedState state) {
    if (state is FeedLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.brandColor,
              strokeWidth: 2,
            ),
            const SizedBox(height: 16),
            Text(
              '피드를 불러오는 중입니다',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
                fontFamily: 'BMEULJIROTTF',
              ),
            ),
          ],
        ),
      );
    }

    if (state is FeedCacheLoading) {
      return Column(
        children: [
          // 캐시된 데이터 표시
          Expanded(child: _buildFeedList(context, state.result)),
          // 백그라운드 로딩 표시
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: AppColors.brandColor,
                    strokeWidth: 2,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '최신 피드를 가져오는 중...',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'BMEULJIROTTF',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    if (state is FeedFetchSuccess) {
      return _buildFeedList(context, state.result);
    }

    if (state is FeedFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.textColor.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              '피드를 불러오는데 실패했습니다',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
                fontFamily: 'BMEULJIROTTF',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '다시 시도해주세요',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textColor.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontFamily: 'BMEULJIROTTF',
              ),
            ),
          ],
        ),
      );
    }

    return NoDataMascote();
  }

  Widget _buildFeedList(BuildContext context, List<Feed> feeds) {
    if (feeds.isEmpty) {
      return NoDataMascote();
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.brightListBackColor,
          borderRadius: BorderRadius.circular(16), // Toss 스타일 라운드 코너
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000), // Toss 스타일 그림자
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16, // Toss 스타일 여백
          crossAxisSpacing: 16,
          children: buildStaggeredFeedTiles(
            feeds,
            onTap: (item) async {
              logger.d("/detail/${item.id}");
              await context.push("/detail/${item.id}", extra: item);
            },
          ),
        ),
      ),
    );
  }
}
