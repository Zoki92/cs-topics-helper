import 'package:cs_topics_app/bloc/bloc.dart';
import 'package:cs_topics_app/models/data_structure.dart';
import 'package:cs_topics_app/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  group('InfiniteScrollBloc tests', () {
    InfiniteScrollBloc infiniteScrollBloc;
    DataStructureRepository dataRepository;
    DataStructure ds;
    DataStructure ds2;
    MarkDownContent md;

    setUp(() {
      dataRepository = MockDataRepository();
      infiniteScrollBloc = InfiniteScrollBloc(dataRepository);
      md = MarkDownContent(name: "Linked List", content: "some content");
      ds = DataStructure(
        name: "Linked List",
        created: DateTime.now().toString(),
        category: "Data Structures",
        markdownContent: md,
      );

      ds2 = DataStructure(
        name: "Array",
        created: DateTime.now().toString(),
        category: "Array",
        markdownContent: md,
      );
    });

    test('check initial state is correct', () {
      expect(infiniteScrollBloc.initialState, InfiniteScrollInitial());
    });

    test('Event is fetch data, state is initial and has reached end of list',
        () {
      when(dataRepository.getDataStructureList()).thenAnswer(
        (_) => Future.value({
          'data': [ds],
          'nextUrl': null
        }),
      );
      final expectedResponse = [
        InfiniteScrollInitial(),
        InfiteScrollSuccess(
            dataStructures: [ds], nextUrl: null, hasReachedMax: true),
      ];

      expectLater(infiniteScrollBloc, emitsInOrder(expectedResponse));
      infiniteScrollBloc.add(FetchData());
    });

    test(
        'Event is fetch data, state is initial state and has not reached end of list',
        () {
      when(dataRepository.getDataStructureList()).thenAnswer(
        (_) => Future.value({
          'data': [ds],
          'nextUrl': 'nextUrl'
        }),
      );

      final expectedResponse = [
        InfiniteScrollInitial(),
        InfiteScrollSuccess(
          dataStructures: [ds],
          nextUrl: 'nextUrl',
          hasReachedMax: false,
        ),
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
      when(dataRepository.getDataStructureList()).thenThrow("oops");

      final expectedResponse = [
        InfiniteScrollInitial(),
        InfiteScrollFailure(message: InfiniteScrollBloc.SERVER_ERROR),
      ];

      expectLater(infiniteScrollBloc, emitsInOrder(expectedResponse));
      infiniteScrollBloc.add(FetchData());
    });

    tearDown(() {
      infiniteScrollBloc.close();
    });
  });
}
