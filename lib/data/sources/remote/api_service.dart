import 'package:dio/dio.dart';
import 'package:timekeeping/core/constants/api_enpoints.dart';

class ApiService {
  final Dio dio;

  const ApiService(this.dio);

  Future<Response> postLogin({
    required String username,
    required String password,
  }) =>
      dio.post(
        ApiEndpoint.LOGIN,
        data: {
          'userId': username,
          'userName': password,
        },
      );

  Future<Response> getUser({
    required String userId,
  }) =>
      dio.get(
        ApiEndpoint.GET_USER_BY_ID,
        queryParameters: {
          'userId': userId,
        },
      );
}
