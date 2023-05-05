import 'package:dio/dio.dart';

import '../view/login_form.dart';

class AuthService {
  final Dio dio = Dio();
  static String? token;
  static String? authority;

  Future<dynamic> login(String email, String senha) async {
    try {
      final response = await dio.post('http://localhost:8080/login', data: {
        'email': email,
        'senha': senha,
      });
      if (response.statusCode == 200) {
        token = response.headers.map['authorization']![0];
        final data = response.data;
        authority = data['perfil'][0]['authority'];
        return authority;
      } else {
        return null;
      }
    } catch (error) {
      throw Exception('Erro ao realizar login');
    }
  }

  String? getAuthority() {
    return authority;
    
  }


}
