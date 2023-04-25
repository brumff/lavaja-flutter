import 'package:dio/dio.dart';

import '../models/servico.dart';

class ServicoService {
  final Dio dio = Dio();

  //ativos e inativos
  Future<List<Servico>> getServico() async {
    final response = await dio.get('http://localhost:8080/api/v1/servico');
    final data = response.data as List<dynamic>;
    return data.map((json) => Servico.fromMap(json)).toList();
  }

  //Somente ativos
  Future<List<Servico>> getServicosAtivos() async {
    final response =
        await dio.get('http://localhost:8080/api/v1/servico/ativos');
    final data = response.data as List<dynamic>;
    return data.map((json) => Servico.fromMap(json)).toList();
  }

  Future<Servico> getServicoById(String id) async {
    final response = await dio.get('http://localhost:8080/api/v1/servico/$id');
    final data = response.data;
    return Servico.fromMap(data);
  }

  Future<void> createServico(String? nome, double? valor, String? tamCarro, double? tempServico, bool? ativo) async {
    await dio.post('http://localhost:8080/api/v1/servico', data: {
      'nome': nome,
      'valor': valor,
      'tamCarro': tamCarro,
      'tempServico': tempServico,
      'ativo': ativo,
    });
  }

  Future<void> updateServico(int? id, String? nome, double? valor,
      String? tamCarro, double? tempServico, bool? ativo) async {
    await dio.put('http://localhost:8080/api/v1/servico', data: {
      'id': id,
      'nome': nome,
      'valor': valor,
      'tamCarro': tamCarro,
      'tempServico': tempServico,
      'ativo': ativo,
    });
  }
}