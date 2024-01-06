import 'package:http/http.dart' as http;


const _baseUrl = 'https://sandbox.api.lettutor.com';
class ApiClient extends http.BaseClient {
  final http.Client _inner = http.Client();
  final String baseUrl;
  String? token;

  ApiClient(this.baseUrl, this.token);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {

    final newRequest = http.Request(request.method, Uri.parse(baseUrl + request.url.toString()))
      ..headers.addAll(request.headers);
    if(token != null){
      newRequest.headers['Authorization'] = 'Bearer $token';
    }

    if (request is http.Request) {
      newRequest.body = request.body;
    }

    return _inner.send(newRequest);
  }
}

final apiClient = ApiClient(_baseUrl, null);
