import 'package:dio/dio.dart';

import '../interface/interface_export.dart';

class HttpClientImpl implements HttpClient {
  final Dio _dio;
  HttpClientImpl(this._dio);

  @override
  Future<HttpResponse> get(String url, {Map<String, String>? headers}) async {
    final response = await _dio.get(
      url,
      options: Options(
        headers: headers,
      ),
    );
    return HttpResponse(
      statusCode: response.statusCode ?? 0,
      data: response.data,
    );
  }
}
