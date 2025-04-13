import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i("🚀 [REQUEST] ${options.method} ${options.uri}");
    logger.d("Headers: ${options.headers}");
    logger.d("Data: ${options.data}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i("✅ [RESPONSE] ${response.statusCode} ${response.requestOptions.uri}");
    logger.d("Response Data: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e("❌ [ERROR] ${err.response?.statusCode} ${err.requestOptions.uri}");
    logger.e("Message: ${err.message}");
    logger.e("Error Data: ${err.response?.data}");
    super.onError(err, handler);
  }
}
