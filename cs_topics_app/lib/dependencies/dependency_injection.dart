import 'package:cs_topics_app/http_api_clients/http_services.dart';
import 'package:cs_topics_app/repository/repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

GetIt di = GetIt.instance;

void setDependencies() {
  Client httpClient = Client();
  DataStructureHttpClient dataClient =
      DataStructureHttpClient(httpClient: httpClient);

  di.registerLazySingleton(() => DataStructureRepository(dataClient));
}
