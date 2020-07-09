import 'package:cs_topics_app/http_api_clients/http_services.dart';
import 'package:cs_topics_app/models/models.dart';
import 'package:cs_topics_app/repository/data_structure_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  group('DataStructureRepository tests', () {
    DataStructureRepository dataStructureRepository;
    DataStructureHttpClient client;
    DataStructure ds;
    MarkDownContent md;

    setUp(() {
      client = MockDataStructureApiClient();
      dataStructureRepository = DataStructureRepository(client);
      md = MarkDownContent(
        name: "Linked List",
        content: "some content",
      );
      ds = DataStructure(
        name: "Linked List",
        created: DateTime.now().toString(),
        category: "Data Structures",
        markdownContent: md,
      );
    });

    test('test getDataStructureList with valid server response', () async {
      when(client.getDataStructuresListFromServer(null)).thenAnswer(
        (_) => Future.value(
          Future.value({
            'data': [ds],
            'nextUrl': null
          }),
        ),
      );
      Map dataAndNextUrl =
          await dataStructureRepository.getDataStructureList(url: null);
      expect(dataAndNextUrl['data'], [ds]);
      expect(dataAndNextUrl['nextUrl'], null);
    });
    test('test getDataStructureList with valid server response and next url',
        () async {
      when(client.getDataStructuresListFromServer(null)).thenAnswer(
        (_) => Future.value(
          Future.value({
            'data': [ds],
            'nextUrl': 'nextUrl'
          }),
        ),
      );
      Map dataAndNextUrl =
          await dataStructureRepository.getDataStructureList(url: null);
      expect(dataAndNextUrl['data'], [ds]);
      expect(dataAndNextUrl['nextUrl'], 'nextUrl');
    });

    test('test getDataStructureList with invalid server response', () async {
      when(client.getDataStructuresListFromServer(null)).thenThrow("oops");

      try {
        Map dataAndNextUrl =
            await dataStructureRepository.getDataStructureList(url: null);
      } catch (e) {
        expect(e.toString(), "oops");
      }
    });
  });
}
