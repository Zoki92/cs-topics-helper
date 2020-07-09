import 'dart:async';

import 'package:bloc/bloc.dart';

part 'on_app_start_event.dart';
part 'on_app_start_state.dart';

class OnAppStartBloc extends Bloc<OnAppStartEvent, OnAppStartState> {
  @override
  OnAppStartState get initialState => OnAppStartInitial();

  @override
  Stream<OnAppStartState> mapEventToState(
    OnAppStartEvent event,
  ) async* {
    if (event is AppStarted) {
      yield OnAppStartLoading();
      await Future.delayed(Duration(seconds: 2));
      yield OnAppStartLoaded();
    }
  }
}
