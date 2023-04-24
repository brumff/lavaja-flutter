import 'package:dio/dio.dart';

class AuthService {
  final Dio dio = Dio();

  Future<dynamic> login(String email, String senha) async {
    try {
      final response = await dio.post('http://localhost:8080/login', data: {
        'email': email,
        'senha': senha,
      });
      if (response.statusCode == 200) {
       return response.data;
      } else {
        return null;
      }
    } catch (error) {
      throw Exception('Erro ao realizar login');
    }
  }

}
