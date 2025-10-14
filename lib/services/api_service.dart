import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  ApiService() {
    // Todo: use var
    dio.options.baseUrl = 'http://10.35.132.88:4001/api/v1/';
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await secureStorage.read(key: 'authToken');
    return {
      'Authorization': token != null ? 'Bearer $token' : '',
      'Content-Type': 'application/json',
    };
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    return await dio.post(
      endpoint,
      data: data,
      options: Options(headers: headers),
    );
  }

  Future<Response> get(String endpoint) async {
    final headers = await _getHeaders();
    return await dio.get(
      endpoint,
      options: Options(headers: headers),
    );
  }

  // Un get avec un getionaire d'erreur pas  tres pertiant  poue le meoment
  Future<void> fetchData(String endpoint) async {
    try {
      final headers = await _getHeaders();
      final response = await dio.get(
        endpoint,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        print('Data fetched successfully: ${response.data}');
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');
      } else {
        print('Request error: $e');
      }
    }
  }
}


