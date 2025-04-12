import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

Widget AppRefreshHeader(){
  return CustomHeader(
    builder: (context, RefreshStatus? mode) {
      if (mode == RefreshStatus.idle ||
          mode == RefreshStatus.canRefresh) {
        return Image.asset(
          'assets/ic_idle_loading.png',
          height: 80,
        );
      } else if (mode == RefreshStatus.refreshing) {
        return Image.asset(
          'assets/ic_loading.png',
          height: 80,
        );
      } else if (mode == RefreshStatus.completed) {
        return Image.asset(
          'assets/ic_complete_loading.png',
          height: 80,
        );
      } else {
        return SizedBox.shrink();
      }
    },
  );
}