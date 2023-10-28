import 'package:dio/dio.dart';
import 'package:lavaja/main.dart';

import '../models/servico.dart';

class DetalhesServicoService {
  final Dio dio = Dio();
  String ip = MyApp.ip;

  Future<List<Servico>> getDetalhesServicos(String id) async {
    final response = await dio.get('${ip}/api/v1/servico/servicos-lavcar?lavacarid=$id');
    final data = response.data as List<dynamic>;
    return data.map((json) => Servico.fromMap(json)).toList();
  }
}