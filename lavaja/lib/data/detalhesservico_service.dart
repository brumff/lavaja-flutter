import 'package:dio/dio.dart';

import '../models/servico.dart';

class DetalhesServicoService {
  final Dio dio = Dio();

  Future<List<Servico>> getDetalhesServicos(String id) async {
    final response = await dio.get('http://192.168.1.20:8080/api/v1/servico/servicos-lavcar?lavacarid=$id');
    final data = response.data as List<dynamic>;
    return data.map((json) => Servico.fromMap(json)).toList();
  }
}