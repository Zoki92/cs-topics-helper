import 'dart:convert';
import 'package:cs_topics_app/models/data_structure.dart';
import 'package:http/http.dart' as http;
import 'base_http_client.dart';
import 'urls.dart';

class DataStructureHttpClient extends BaseHttpClient {
  final http.Client httpClient;

  DataStructureHttpClient({this.httpClient})
      : assert(httpClient != null),
        super(httpClient: httpClient);

  Future<Map> getDataStructuresListFromServer(String url) async {
    String newUrl = url ?? dataStructureListUrl;
    http.Response response = await getApiCallResponse(
      errorMessage: 'Failed to get data from the server.',
      url: newUrl,
    );
    final responseBody = jsonDecode(response.body);

    Map dataAndNext = {
      "data": DataStructure.toListOfDataStructures(responseBody['results']),
      "nextUrl": responseBody['next']
    };
    return dataAndNext;
  }
}
