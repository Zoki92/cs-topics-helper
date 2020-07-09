import 'package:cs_topics_app/http_api_clients/http_services.dart';

class DataStructureRepository {
  final DataStructureHttpClient _dataStructureHttpClient;

  DataStructureRepository(this._dataStructureHttpClient)
      : assert(_dataStructureHttpClient != null);

  Future<Map> getDataStructureList({String url}) async {
    Map dataAndNextUrl = await this
        ._dataStructureHttpClient
        .getDataStructuresListFromServer(url);
    return dataAndNextUrl;
  }
}
