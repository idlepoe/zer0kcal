import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/bottom_navigation_button.dart';
import '../../../core/widgets/no_data.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "공유피드",
      body: NoDataMascote(),
      bottomNavigationBar: BottomNavigationButton(
        onTap: () {
          context.push("/upload");
        },
        buttonText: "업로드",
      ),
    );
  }
}
