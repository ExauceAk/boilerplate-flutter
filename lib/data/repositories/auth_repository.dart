import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user.dart';
import '../../services/api_service.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository(this.apiService);

// Initialisez une instance globale
  final secureStorage = FlutterSecureStorage();

  Future<void> login(String email, String password) async {

    final response = await apiService.post('/users/login', {
      'identity': email,
      'password': password,
    });

    if (response.statusCode == 200 || response.statusCode == 201 ) {
      final token = response.data['data']['token'];;
      final storage = FlutterSecureStorage();
      await storage.write(key: 'authToken', value: token);
    } else {
      throw Exception("Echec de l'inscription");
    }
  }

  Future<void> register(String email, String fullname, String password , String confirmPassword, String referrerCode) async {

    final response = await apiService.post('/users/register', {
      'email': email,
      'fullname': fullname,
      'password': password,
      'confirmPassword': confirmPassword,
      'referrerCode': referrerCode,
    });

    if (response.statusCode == 200 || response.statusCode == 201 ) {

    } else {
      throw Exception('Echec de la connection');
    }
  }

  Future<void> resetPassword(String id, String password , String confirmPassword) async {

    final response = await apiService.post('/users/reset-password', {
      'id': id,
      'password': password,
      'confirmPassword': confirmPassword,
    });

    if (response.statusCode == 200 || response.statusCode == 201 ) {

    } else {
      throw Exception('Echec de la connection');
    }
  }

  Future<void> forgotPasswordRequest(String email) async {

    final response = await apiService.post('/users/send-forgot-password-link', {
      'email': email,
    });

    if (response.statusCode == 200 || response.statusCode == 201 ) {

    } else {
      throw Exception("Echec de l'opération");
    }
  }

  Future<void> resendForgotPasswordCode(String email) async {

    final response = await apiService.post('/users/resend-code', {
      'email': email,
    });

    if (response.statusCode == 200 || response.statusCode == 201 ) {

    } else {
      throw Exception("Echec de l'opération");
    }
  }

  Future<void> verifyCode(String email, String code) async {

    final response = await apiService.post('/users/verify-code', {
      'email': email,
      'code': code
    });

    if (response.statusCode == 200 || response.statusCode == 201 ) {

    } else {
      throw Exception("Echec de l'opération");
    }
  }

  Future<User> getMe() async {

    final response = await apiService.get('/users/me');

    if (response.statusCode == 200) {
      return User.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to fetch user');
    }
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'authToken'); // Supprimer le jeton
    print('User logged out');
  }

}
