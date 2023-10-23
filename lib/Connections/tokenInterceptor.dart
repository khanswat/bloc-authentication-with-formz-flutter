import 'package:dio/dio.dart';

class TokenInterceptors extends Interceptor {
  var token;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.baseUrl = 'https://.......';

    options.headers['Authorization'] = 'Bearer $token';

    handler.next(options);
    // print('token: $token');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    handler.next(err);
  }
}
