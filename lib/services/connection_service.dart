import 'package:http/http.dart' as http;

class ConnectionService {
  late http.Client _client;

  ConnectionService({required http.Client httpClient}) {
    _client = httpClient;
  }

  http.Client returnConnection() {
    return _client;
  }
}
