import 'package:dio/dio.dart';

import '../models/lavacar.dart';

class LavacarService {
  final Dio dio = Dio();

  Future<List<Lavacar>> getLavacar() async {
    final response = await dio.get('http://localhost:8080/api/v1/lavacar');
    final data = response.data as List<dynamic>;
    return data.map((json) => Lavacar.fromMap(json)).toList();
  }

  //Verificar com o felipe se está correto dessa forma e como chamar a parte dos horarios
  Future<void> createLavacar(
      String? cnpj,
      String? nome,
      String? logradouro,
      String? numero,
      String? complemento,
      String? bairro,
      String? cidade,
      String? cep,
      String? telefone1,
      String? telefone2,
      String? email,
      bool? ativo) async {
    await dio.post('http://localhost:8080/api/v1/clientes', data: {
      'cnpj': cnpj,
      'nome': nome,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'cep': cep,
      'telefone1': telefone1,
      'telefone2': telefone2,
      'email': email,
      'ativo': ativo
    });
  }

  Future<void> updateLavacar(
      int? id,
      String? cnpj,
      String? nome,
      String? logradouro,
      String? numero,
      String? complemento,
      String? bairro,
      String? cidade,
      String? cep,
      String? telefone1,
      String? telefone2,
      String? email,
      bool? ativo) async {
    await dio.put('http://localhost:8080/api/v1/clientes/$id', data: {
      'cnpj': cnpj,
      'nome': nome,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'cep': cep,
      'telefone1': telefone1,
      'telefone2': telefone2,
      'email': email,
      'ativo': ativo
    });
  }

  Future<void> deleteLavacar(int? id) async {
    await dio.delete('http://localhost:8080/api/v1/clientes/$id');
  }
}
