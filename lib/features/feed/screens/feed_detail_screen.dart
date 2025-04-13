import 'package:flutter/cupertino.dart';
import 'package:zer0kcal/core/widgets/app_scaffold.dart';

class FeedDetailScreen extends StatefulWidget {
  final String id;
  const FeedDetailScreen({super.key, required this.id});

  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    },);
  }



  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Text("detail"));
  }

}
