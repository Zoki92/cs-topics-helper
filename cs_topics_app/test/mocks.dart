import 'package:cs_topics_app/api_clients/http_api_clients.dart';
import 'package:cs_topics_app/bloc/bloc.dart';
import 'package:cs_topics_app/repositories/repository.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockDataRepository extends Mock implements DataRepository {}

class MockHttpClient extends Mock implements http.Client {}

class MockDataStructureApiClient extends Mock
    implements DataStructureApiClient {}

class MockResponse extends Mock implements http.Response {}

class MockScrollBloc extends Mock implements InfiniteScrollBloc {}
