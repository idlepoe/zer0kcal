import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:zer0kcal/core/widgets/app_inkwell.dart';
import 'package:zer0kcal/features/feed/bloc/feed_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/dio_interceptor.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/no_data.dart';
import '../bloc/feed_event.dart';
import '../bloc/feed_state.dart';
import '../models/feed.dart';
import '../widgets/app_refresh_header.dart';
import '../widgets/build_staggered_feed_tiles.dart';

class FeedScreen extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, FeedState state) async {
        if (state is FeedUploadRequested) {
          var result = await context.push("/upload");
          await Future.delayed(Duration(seconds: 2));
          context.read<FeedBloc>().add(FeedFetch());
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
                padding: const EdgeInsets.all(5),
                child: Image.asset("assets/ic_upload_feed.png"),
              ),
            ),
          ],
          body: SmartRefresher(
            controller: _refreshController,
            onRefresh: () {
              context.read<FeedBloc>().add(FeedFetch());
              _refreshController.refreshCompleted();
            },
            header: AppRefreshHeader(),
            child:
                list.isEmpty
                    ? NoDataMascote()
                    : Padding(
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
                          children: buildStaggeredFeedTiles(
                            list,
                            onTap: (item) async {
                              logger.d("/detail/${item.id}");
                              var result = await context.push(
                                "/detail/${item.id}",
                              );
                            },
                          ),
                        ),
                      ),
                    ),
          ),
        );
      },
    );
  }
}
