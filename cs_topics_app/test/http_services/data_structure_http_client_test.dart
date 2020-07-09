import 'package:cs_topics_app/http_api_clients/http_services.dart';
import 'package:cs_topics_app/http_api_clients/urls.dart';
import 'package:cs_topics_app/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  group('DataStructureHttpClient tests', () {
    DataStructureHttpClient dataStructureHttpClient;
    Client httpClient;
    String jsonResponse;
    DataStructure ds;
    MarkDownContent md;
    setUp(() {
      httpClient = MockHttpClient();
      dataStructureHttpClient = DataStructureHttpClient(httpClient: httpClient);
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
      jsonResponse = """
      {
          "count": 1,
          "next": null,
          "previous": null,
          "results": [
              {
                  "name": "Linked List",
                  "created": "2020-07-09T09:24:45.971928Z",
                  "category": "Data Structures",
                  "markdown_content": {
                      "name": "Linked List",
                      "content": "some content"
                  }
              }
          ]
      }
      """;
    });

    test(
        'getDataStructuresListFromServer getting valid response with null url input',
        () async {
      var response = MockResponse();
      when(response.statusCode).thenReturn(200);
      when(response.body).thenReturn(jsonResponse);
      when(httpClient.get(dataStructureListUrl))
          .thenAnswer((realInvocation) => Future.value(response));

      Map mapRes =
          await dataStructureHttpClient.getDataStructuresListFromServer(null);

      expect(mapRes['data'].length, 1);
      expect(mapRes['data'][0], ds);
      expect(mapRes['nextUrl'], null);
    });
    test(
        'getDataStructuresListFromServer getting invalid response with null url input',
        () async {
      var response = MockResponse();
      when(response.statusCode).thenReturn(500);
      when(httpClient.get(dataStructureListUrl))
          .thenAnswer((_) => Future.value(response));

      try {
        Map mapRes =
            await dataStructureHttpClient.getDataStructuresListFromServer(null);
      } catch (e) {
        expect(e.toString(), 'Exception: Failed to get data from the server.');
      }
    });
  });
}
