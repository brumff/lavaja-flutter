import 'package:dio/dio.dart';
import 'package:lavaja/models/contratarservico.dart';

import 'auth_service.dart';

class ContratarServicoService {
  final Dio dio = Dio();

  Future<List<ContratarServico>> getListarServicosLavacar() async {
    dio.options.headers = {'authorization': AuthService.token};
    final response = await dio
        .get('http://localhost:8080/api/v1/contratarservico/lavacar-servicos');
    final data = response.data as List<dynamic>;
    return data.map((json) => ContratarServico.fromMap(json)).toList();
  }

  Future<void> patchContratarServico(int? id, String? statusServico) async {
    dio.options.headers = {'authorization': AuthService.token};
    await dio.put(
      'http://localhost:8080/api/v1/contratarservico/lavacar-servicos/$id',
      data: {
        'statusServico': statusServico,
      },
    );
  }
}