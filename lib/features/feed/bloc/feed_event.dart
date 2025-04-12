import 'package:image_picker/image_picker.dart';

abstract class FeedEvent {}

class FeedInitEvent extends FeedEvent {}

class FeedFetch extends FeedEvent {}

class FeedPressed extends FeedEvent {
  final XFile xFile;

  FeedPressed(this.xFile);
}
