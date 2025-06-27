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
          context.read<FeedBloc>().add(FeedFetch());
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
                    context.read<FeedBloc>().add(FeedFetch());
                    _refreshController.refreshCompleted();
                  },
                  header: AppRefreshHeader(),
                  child:
                      state is FeedLoading
                          ? Center(
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
                          )
                          : _buildFeedContent(context, state),
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
    final List<Feed> feeds =
        state is HasFeedList ? (state as HasFeedList).result.cast<Feed>() : [];

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
              await context.push("/detail/${item.id}");
            },
          ),
        ),
      ),
    );
  }
}
