import 'package:dio/dio.dart';
import 'package:lavaja/data/prefs_service.dart';
import 'package:lavaja/main.dart';

import '../models/lavacar.dart';
import 'auth_service.dart';

class LavacarService {
  final Dio dio = Dio();
  String ip = MyApp.ip;

  Future<List<Lavacar>> getLavacar() async {
    String? token = await PrefsService.getToken();
    String? tokenAuth = '';

    if (token != null) {
      tokenAuth = token;
      print('token do shared ${tokenAuth}');
    } else {
      tokenAuth = AuthService.token;
      print('token do shared ${tokenAuth}');
    }
    dio.options.headers = {'authorization': tokenAuth};
    final response = await dio.get('${ip}0/api/v1/lavacar/todos');
    final data = response.data as List<dynamic>;
    return data.map((json) => Lavacar.fromMap(json)).toList();
  }

  Future<List<Lavacar>> getLavacarAberto() async {
    String? token = await PrefsService.getToken();
    String? tokenAuth = '';

    if (token != null) {
      tokenAuth = token;
      print('token do shared ${tokenAuth}');
    } else {
      tokenAuth = AuthService.token;
      print('token do shared ${tokenAuth}');
    }
    dio.options.headers = {'authorization': tokenAuth};
    final response = await dio.get('${ip}/api/v1/lavacar/abertos');
    final data = response.data as List<dynamic>;
    return data.map((json) => Lavacar.fromMap(json)).toList();
  }

  Future<Lavacar> getLavacarByToken() async {
    String? token = await PrefsService.getToken();
    String? tokenAuth = '';

    if (token != null) {
      tokenAuth = token;
      print('token do shared ${tokenAuth}');
    } else {
      tokenAuth = AuthService.token;
      print('token do shared ${tokenAuth}');
    }
    dio.options.headers = {'authorization': tokenAuth};
    final response = await dio.get('${ip}/api/v1/lavacar/meu-lavacar');
    final data = response.data;
    return Lavacar.fromMap(data);
  }

  Future<Lavacar> getLavacarById(String id) async {
    final response = await dio.get('${ip}/api/v1/lavacar/$id');
    final data = response.data;
    print(data);
    return Lavacar.fromMap(data);
  }

  Future<String> createLavacar(
      String? cnpj,
      String? nome,
      String? rua,
      String? numero,
      String? complemento,
      String? bairro,
      String? cidade,
      String? cep,
      String? longitude,
      String? latitude,
      String? telefone1,
      String? telefone2,
      String? email,
      String? senha,
      String? confSenha) async {
    try {
      final response = await dio.post('${ip}/api/v1/lavacar', data: {
        'cnpj': cnpj,
        'nome': nome,
        'rua': rua,
        'numero': numero,
        'complemento': complemento,
        'bairro': bairro,
        'cidade': cidade,
        'cep': cep,
        'latitude': latitude,
        'longitude': longitude,
        'telefone1': telefone1,
        'telefone2': telefone2,
        'email': email,
        'senha': senha,
        'confSenha': confSenha,
      });

      if (response.statusCode == 200) {
        return 'Cadastro realizado com sucesso!';
      } else {
        return 'Erro ao cadastrar: ${response.data}';
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Map<String, dynamic> errorResponse = e.response!.data;
        if (errorResponse.containsKey("message")) {
          String errorMessage = errorResponse["message"];
          print(errorMessage);
          return '$errorMessage';
        }
      }
      return 'Erro no Dio: $e';
    }
  }

  Future<void> updateLavacar(
    String? cnpj,
    String? nome,
    String? rua,
    String? numero,
    String? complemento,
    String? bairro,
    String? cidade,
    String? cep,
    String? longitude,
    String? latitude,
    String? telefone1,
    String? telefone2,
    String? email,
  ) async {
    String? token = await PrefsService.getToken();
    String? tokenAuth = '';

    if (token != null) {
      tokenAuth = token;
      print('token do shared ${tokenAuth}');
    } else {
      tokenAuth = AuthService.token;
      print('token do shared ${tokenAuth}');
    }
    dio.options.headers = {'authorization': tokenAuth};
    await dio.put('${ip}/api/v1/lavacar/meu-lavacar', data: {
      'cnpj': cnpj,
      'nome': nome,
      'rua': rua,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'cep': cep,
      'longitude': longitude,
      'latitude': latitude,
      'telefone1': telefone1,
      'telefone2': telefone2,
      'email': email,
    });
  }

  Future<void> abrirLavacar(bool? aberto) async {
    String? token = await PrefsService.getToken();
    String? tokenAuth = '';

    if (token != null) {
      tokenAuth = token;
      print('token do shared ${tokenAuth}');
    } else {
      tokenAuth = AuthService.token;
      print('token do shared ${tokenAuth}');
    }
    dio.options.headers = {'authorization': tokenAuth};
    dio.options.contentType = 'application/json';
    await dio.post('${ip}/api/v1/lavacar/abrir', data: aberto ?? false);
  }
}
