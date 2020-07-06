import 'package:cs_topics_app/bloc/startapp_bloc/on_appstart_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnAppstartBloc', () {
    OnAppstartBloc onAppstartBloc;
    setUp(() {
      onAppstartBloc = OnAppstartBloc();
    });

    test('initial state is OnAppstartInitial', () {
      expect(onAppstartBloc.initialState, OnAppstartInitial());
    });

    test('on GetInitialDataEvent', () {
      final expectedResponse = [
        OnAppstartInitial(),
        Loading(),
        SplashPageShown(),
      ];

      expectLater(onAppstartBloc, emitsInOrder(expectedResponse));

      onAppstartBloc.add(ShowSplashPage());
    });

    tearDown(() {
      onAppstartBloc?.close();
    });
  });
}
