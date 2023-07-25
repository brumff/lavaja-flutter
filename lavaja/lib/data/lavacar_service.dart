import 'package:dio/dio.dart';

import '../models/lavacar.dart';
import 'auth_service.dart';

class LavacarService {
  final Dio dio = Dio();

  Future<List<Lavacar>> getLavacar() async {
    dio.options.headers = {'authorization': AuthService.token};
    final response =
        await dio.get('http://192.168.1.7:8080/api/v1/lavacar/todos');
    final data = response.data as List<dynamic>;
    return data.map((json) => Lavacar.fromMap(json)).toList();
  }

  Future<Lavacar> getLavacarByToken() async {
    dio.options.headers = {'authorization': AuthService.token};
    final response =
        await dio.get('http://192.168.1.7:8080/api/v1/lavacar/meu-lavacar');
    final data = response.data;
    return Lavacar.fromMap(data);
  }

  Future<Lavacar> getLavacarById(String id) async {
    final response =
        await dio.get('http://192.168.1.7:8080/api/v1/lavacar/$id');
    final data = response.data;
    return Lavacar.fromMap(data);
  }

  Future<void> createLavacar(
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
    await dio.post('http://192.168.1.7:8080/api/v1/lavacar', data: {
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
      'senha': senha,
      'confSenha': confSenha,
    });
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
    dio.options.headers = {'authorization': AuthService.token};
    await dio.put('http://192.168.1.7:8080/api/v1/lavacar/meu-lavacar', data: {
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
    dio.options.headers = {'authorization': AuthService.token};
    dio.options.contentType = 'application/json';
    await dio.post('http://192.168.1.7:8080/api/v1/lavacar/abrir',
        data: aberto ?? false);
  }
}
