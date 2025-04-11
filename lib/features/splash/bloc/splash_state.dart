abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashSuccess extends SplashState {}

class SplashFailure extends SplashState {
  String message;

  SplashFailure({required this.message});
}
