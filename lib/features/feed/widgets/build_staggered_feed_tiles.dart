import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/feed.dart';
import 'build_feed_card.dart';
import 'build_feed_card_mascote.dart';

List<StaggeredGridTile> buildStaggeredFeedTiles(List<Feed> items) {
  List<StaggeredGridTile> tiles = [];

  for (int i = 0; i < items.length;) {
    // 1. 하나짜리 전체 너비 (2칸)
    if (i < items.length) {
      tiles.add(
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 0.8,
          child: buildFeedCardWithMascote(items[i], i),
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
          child: buildFeedCard(items[i], i),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 0.9,
          child: buildFeedCard(items[i + 1], i),
        ),
      ]);
      i += 2;
    }
  }
  return tiles;
}