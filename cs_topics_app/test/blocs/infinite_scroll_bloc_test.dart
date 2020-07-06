import 'package:cs_topics_app/bloc/bloc.dart';
import 'package:cs_topics_app/models/data_structure.dart';
import 'package:cs_topics_app/repositories/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  group('InfiniteScrollBloc tests', () {
    InfiniteScrollBloc infiniteScrollBloc;
    DataRepository dataRepository;
    DataStructure ds;
    DataStructure ds2;

    setUp(() {
      dataRepository = MockDataRepository();
      infiniteScrollBloc = InfiniteScrollBloc(dataRepository);
      ds = DataStructure(
        id: 1,
        name: "Linked List",
        created: DateTime.now().toString(),
        contents: [],
      );
      ds2 = DataStructure(
        id: 1,
        name: "Array",
        created: DateTime.now().toString(),
        contents: [],
      );
    });

    test('check initial state is correct', () {
      expect(infiniteScrollBloc.initialState, InfiniteScrollInitial());
    });

    test('Event is fetch data, state is initial and has reached end of list',
        () {
      when(dataRepository.getDataAndNextUrl()).thenAnswer(
        (_) => Future.value({
          'data': [ds],
          'nextUrl': null
        }),
      );
      final expectedResponse = [
        InfiniteScrollInitial(),
        DataFetchSuccess(data: [ds], nextUrl: null, hasReachedMax: true),
      ];

      expectLater(infiniteScrollBloc, emitsInOrder(expectedResponse));
      infiniteScrollBloc.add(FetchData());
    });

    test(
        'Event is fetch data, state is initial state and has not reached end of list',
        () {
      when(dataRepository.getDataAndNextUrl()).thenAnswer(
        (_) => Future.value({
          'data': [ds],
          'nextUrl': 'nextUrl'
        }),
      );

      final expectedResponse = [
        InfiniteScrollInitial(),
        DataFetchSuccess(data: [ds], nextUrl: 'nextUrl', hasReachedMax: false),
      ];

      expectLater(infiniteScrollBloc, emitsInOrder(expectedResponse));
      infiniteScrollBloc.add(FetchData());
    });
    // TODO check how to deal with this test.
    // test(
    //     'Event is fetch data, state is fetch data success, and it has reached end of list',
    //     () {
    //   final expectedResponse = [
    //     DataFetchSuccess(data: [ds], nextUrl: 'nextUrl', hasReachedMax: false),
    //     DataFetchSuccess(data: [ds, ds2], nextUrl: 'null', hasReachedMax: true),
    //   ];

    //   when(dataRepository.getDataAndNextUrl(nextUrl: 'nextUrl')).thenAnswer(
    //     (_) => Future.value({
    //       'data': [ds2],
    //       'nextUrl': null
    //     }),
    //   );

    //   expectLater(infiniteScrollBloc, emitsInOrder(expectedResponse));
    //   infiniteScrollBloc.add(FetchData());
    // });
    test('Event is fetch data, and there is server problem', () {
      when(dataRepository.getDataAndNextUrl()).thenThrow("oops");

      final expectedResponse = [
        InfiniteScrollInitial(),
        DataFetchFailed(message: InfiniteScrollBloc.ERROR_MSG),
      ];

      expectLater(infiniteScrollBloc, emitsInOrder(expectedResponse));
      infiniteScrollBloc.add(FetchData());
    });

    tearDown(() {
      infiniteScrollBloc.close();
    });
  });
}
