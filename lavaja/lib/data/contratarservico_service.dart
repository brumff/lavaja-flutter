import 'package:dio/dio.dart';
import 'package:lavaja/models/contratarservico.dart';
import 'package:lavaja/models/servico.dart';

import 'auth_service.dart';

class ContratarServicoService {
  final Dio dio = Dio();

  Future<List<ContratarServico>> getListarServicosLavacar() async {
    dio.options.headers = {'authorization': AuthService.token};
    final response = await dio.get(
        'http://192.168.1.20:8080/api/v1/contratarservico/lavacar-servicos');
    final data = response.data as List<dynamic>;
    return data.map((json) => ContratarServico.fromMap(json)).toList();
  }

  Future<List<ContratarServico>> getListarServicosDonocarro() async {
    dio.options.headers = {'authorization': AuthService.token};
    final response = await dio.get(
        'http://192.168.1.20:8080/api/v1/contratarservico/donocarro-servicos');
    final data = response.data as List<dynamic>;
    return data.map((json) => ContratarServico.fromMap(json)).toList();
  }

  Future<void> patchContratarServico(int? id, String? statusServico) async {
    dio.options.headers = {'authorization': AuthService.token};

    await dio.patch(
      'http://192.168.1.20:8080/api/v1/contratarservico/$id',
      data: {
        'statusServico': statusServico,
      },
    );
  }

  Future<void> deletarContratarServico(int? id) async {
    dio.options.headers = {'authorization': AuthService.token};
    await dio.delete('http://192.168.1.20:8080/api/v1/contratarservico/$id');
  }

  Future<void> createContratarServico(
      String? origem, String? placaCarro, int? servicoId, String? telefone) async {
    dio.options.headers = {'authorization': AuthService.token};
    await dio.post(
      'http://192.168.1.20:8080/api/v1/contratarservico',
      data: {
        'origem': origem,
        'placaCarro': placaCarro,
        'servico': {'id': servicoId},
        'telefone': telefone
      },
    );
  }

    Future<void> createContratarServicoDonoCarro(
      String? origem,  int? servicoId, int? veiculo) async {
    dio.options.headers = {'authorization': AuthService.token};
    await dio.post(
      'http://192.168.1.20:8080/api/v1/contratarservico',
      data: {
        'origem': origem,
        'servico': {'id': servicoId},
        'veiculo': {'id': veiculo},


      },
    );
  }
}
