abstract class HttpClient {
  Future<HttpResponse> get(String url, {Map<String, String>? headers});
}

class HttpResponse {
  final int statusCode;
  final dynamic data;

  HttpResponse({
    required this.statusCode,
    required this.data,
  });
}
