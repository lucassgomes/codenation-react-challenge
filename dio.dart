import 'package:dio/dio.dart';
import 'constants.dart';

class CustomDio {
  Dio _dio;

  CustomDio() {
    this._dio = Dio(BaseOptions(
        baseUrl: API_URL + API_VERSION + CHALLENGE_PATH,
        queryParameters: {"token": TOKEN}));
  }

  Dio get dio => _dio;
  set dio(Dio dio) => _dio = dio;
}
