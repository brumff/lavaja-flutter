import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lavaja/data/prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio dio = Dio();
  static String? token;
  static String? authority;
  static String? aberto;
  static String? emailUsuario;
  static String? nomeUsuario;
  static int?  userId;


  Future<dynamic> login(String email, String senha) async {
    try {
      final response = await dio.post('http://192.168.1.20:8080/login', data: {
        'email': email,
        'senha': senha,
      });
      if (response.statusCode == 200) {
        token = response.headers.map['authorization']![0];
        final data = response.data;
        authority = data['perfil'][0]['authority'];
        emailUsuario = data['email'];
        nomeUsuario = data['nome'];
        userId = data['id'];
        await PrefsService.save(token!, userId!);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Erro ao realizar login');
    }
  }


  static Map<String, String> getUsuario() {
    return {'email': emailUsuario ?? '', 'nome': nomeUsuario ?? ''};
  }

  String? getAuthority() {
    return authority;
  }

  void logout() {
    token = null;
    PrefsService.logout();
  }
}
