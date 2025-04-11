import 'package:image_picker/image_picker.dart';

abstract class UploadEvent {}

class UploadInitEvent extends UploadEvent {}

class UploadPressed extends UploadEvent {
  final XFile xFile;
  UploadPressed(this.xFile);
}
