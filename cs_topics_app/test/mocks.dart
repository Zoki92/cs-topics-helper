import 'package:cs_topics_app/http_api_clients/http_services.dart';
import 'package:cs_topics_app/repository/repository.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockDataRepository extends Mock implements DataStructureRepository {}

class MockHttpClient extends Mock implements http.Client {}

class MockDataStructureApiClient extends Mock
    implements DataStructureHttpClient {}

class MockResponse extends Mock implements http.Response {}
