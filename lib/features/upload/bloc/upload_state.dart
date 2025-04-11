abstract class UploadState {}

class UploadInitial extends UploadState {}

class UploadLoading extends UploadState {}

class UploadSuccess extends UploadState {}

class UploadFailure extends UploadState {}