import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zer0kcal/features/Splash/bloc/Splash_event.dart';
import 'package:zer0kcal/features/Splash/bloc/Splash_state.dart';
import 'package:zer0kcal/repositories/feed_repository.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashInitEvent>((event, emit) async {});
  }
}
