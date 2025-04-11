import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zer0kcal/features/upload/bloc/upload_event.dart';
import 'package:zer0kcal/features/upload/bloc/upload_state.dart';
import 'package:zer0kcal/repositories/feed_repository.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final FeedRepository repository;

  UploadBloc(this.repository) : super(UploadInitial()) {
    on<UploadPressed>((event, emit) async {
      emit(UploadLoading());
      String url = await repository.uploadPicture(xFile: event.xFile);
      if (url.isNotEmpty) {
        emit(UploadSuccess());
      } else {
        emit(UploadFailure());
      }
    });
  }
}
