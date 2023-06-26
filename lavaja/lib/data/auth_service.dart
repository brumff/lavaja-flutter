import 'package:dio/dio.dart';
import 'package:lavaja/data/prefs_service.dart';

class AuthService {
  final Dio dio = Dio();
  static String? token;
  static String? authority;

  Future<dynamic> login(String email, String senha) async {
    try {
      final response = await dio.post('http://192.168.1.7:8080/login', data: {
        'email': email,
        'senha': senha,
      });
      if (response.statusCode == 200) {
        token = response.headers.map['authorization']![0];
        final data = response.data;
        authority = data['perfil'][0]['authority'];
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Erro ao realizar login');
    }
  }

  String? getAuthority() {
    return authority;
  }

  void logout() {
    token = null; 
  }
}
