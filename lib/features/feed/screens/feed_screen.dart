import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:screenshot/screenshot.dart';
import 'package:zer0kcal/core/widgets/app_inkwell.dart';
import 'package:zer0kcal/features/feed/bloc/feed_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/bottom_navigation_button.dart';
import '../../../core/widgets/no_data.dart';
import '../bloc/feed_event.dart';
import '../bloc/feed_state.dart';
import '../models/feed.dart';

class FeedScreen extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, FeedState state) async {
        if (state is FeedUploadRequested) {
          var result = await context.push("/upload");
          if (result == true) {
            context.read<FeedBloc>().add(FeedFetch());
          }
        } else if (state is FeedFailure) {
          showOkAlertDialog(context: context, message: state.message);
        }
      },
      builder: (context, FeedState state) {
        List<Feed> list = [];
        if (state is FeedFetchSuccess ||
            state is FeedFailure ||
            state is FeedUploadRequested) {
          _refreshController.refreshCompleted();
        }
        if (state is HasFeedList) {
          list = (state as HasFeedList).result;
        }
        return AppScaffold(
          title: "공유피드",
          actions: [
            AppInkWell(
              onTap: () async {
                context.read<FeedBloc>().add(FeedUploadPressed());
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Image.asset("assets/ic_upload_feed.png"),
              ),
            ),
          ],
          body:
              list.isNotEmpty
                  ? SmartRefresher(
                    controller: _refreshController,
                    onRefresh: () {
                      _refreshController.requestRefresh();
                      context.read<FeedBloc>().add(FeedFetch());
                      _refreshController.refreshCompleted();
                    },
                    header: CustomHeader(
                      builder: (context, RefreshStatus? mode) {
                        if (mode == RefreshStatus.idle ||
                            mode == RefreshStatus.canRefresh) {
                          // 당기기 전 (기본 대기 상태)
                          return Image.asset(
                            'assets/ic_idle_loading.png', // 🍊 당겨주세요 이미지
                            height: 80,
                          );
                        } else if (mode == RefreshStatus.refreshing) {
                          // 로딩 중
                          return Image.asset(
                            'assets/ic_loading.png', // 🍊 로딩 중 이미지
                            height: 80,
                          );
                        } else if (mode == RefreshStatus.completed) {
                          return Image.asset(
                            'assets/ic_complete_loading.png', // 🍊 로딩 중 이미지
                            height: 80,
                          );
                        } else {
                          return SizedBox.shrink(); // 그 외: releaseToRefresh 등
                        }
                      },
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.brightListBackColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                          children: _buildStaggeredFeedTiles(list),
                        ),
                      ),
                    ),
                  )
                  : NoDataMascote(),
          // bottomNavigationBar: BottomNavigationButton(
          //   onTap: () async {
          //     var result = await context.push("/upload");
          //     if (result == true) {
          //       context.read<FeedBloc>().add(FeedFetch());
          //     }
          //   },
          //   buttonText: "업로드",
          // ),
        );
      },
    );
  }

  List<StaggeredGridTile> _buildStaggeredFeedTiles(List<Feed> items) {
    List<StaggeredGridTile> tiles = [];

    for (int i = 0; i < items.length;) {
      // 1. 하나짜리 전체 너비 (2칸)
      if (i < items.length) {
        tiles.add(
          StaggeredGridTile.count(
            crossAxisCellCount: 3,
            mainAxisCellCount: 0.8,
            child: _buildFeedCardWithMascote(items[i], i),
          ),
        );
        i++;
      }

      // 2. 나란히 두 개 (1칸씩)
      if (i + 1 < items.length) {
        tiles.addAll([
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 0.9,
            child: _buildFeedCard(items[i], i),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 0.9,
            child: _buildFeedCard(items[i + 1], i),
          ),
        ]);
        i += 2;
      }
    }
    return tiles;
  }

  Widget _buildFeedCardWithMascote(Feed item, int index) {
    Widget imgWidget = Expanded(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(item.url, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
    Widget descWidget = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment:
            index % 4 == 0
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
        children: [
          Image.asset(
            index % 4 == 0 ? "assets/ic_orange1.png" : "assets/ic_orange2.png",
            height: 70,
            fit: BoxFit.fitHeight,
          ),
          Text(
            item.result,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(8),
      child: IntrinsicHeight(
        child: Row(
          children:
              index % 4 == 0
                  ? [imgWidget, SizedBox(width: 10), descWidget]
                  : [descWidget, SizedBox(width: 10), imgWidget],
        ),
      ),
    );
  }

  Widget _buildFeedCard(Feed item, int index) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.url,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.result,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
