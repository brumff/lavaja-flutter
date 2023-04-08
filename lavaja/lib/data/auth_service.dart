import 'package:dio/dio.dart';

class AuthService {
  final Dio dio = Dio();

  Future<dynamic> loginDonoCarro(String email, String senha) async {
    try {
      final response = await dio.post('http://localhost:8080/loginDonoCarro', data: {
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

    Future<dynamic> loginLavaCar(String email, String senha) async {
    try {
      final response = await dio.post('http://localhost:8080/loginLavaCar', data: {
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
