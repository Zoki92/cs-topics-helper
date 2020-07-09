import 'package:http/http.dart' as http;

class BaseHttpClient {
  final http.Client httpClient;

  BaseHttpClient({this.httpClient});

  Future<http.Response> getApiCallResponse(
      {String url, String errorMessage}) async {
    print("here url $url");
    http.Response response;
    try {
      response = await httpClient.get(url);
    } catch (e) {
      print(e);
    }

    if (response.statusCode != 200) {
      throw Exception(errorMessage);
    }
    return response;
  }
}
