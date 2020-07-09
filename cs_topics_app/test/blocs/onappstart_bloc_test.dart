import 'package:cs_topics_app/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnAppstartBloc', () {
    OnAppStartBloc onAppstartBloc;
    setUp(() {
      onAppstartBloc = OnAppStartBloc();
    });

    test('initial state is OnAppstartInitial', () {
      expect(onAppstartBloc.initialState, isA<OnAppStartInitial>());
    });

    test('on GetInitialDataEvent', () {
      final expectedResponse = [
        isA<OnAppStartInitial>(),
        isA<OnAppStartLoading>(),
        isA<OnAppStartLoaded>(),
      ];

      expectLater(onAppstartBloc, emitsInOrder(expectedResponse));

      onAppstartBloc.add(AppStarted());
    });

    tearDown(() {
      onAppstartBloc?.close();
    });
  });
}
