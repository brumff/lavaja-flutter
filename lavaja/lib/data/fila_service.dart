import 'package:dio/dio.dart';

import 'auth_service.dart';

class FilaService {
  final Dio dio = Dio();

  Future<void> createFila(String? origem, String? statusServico,
      DateTime? dataServico, int? donoCarro, int? servico) async {
    dio.options.headers = {'authorization': AuthService.token};
    await dio.post('http://192.168.100.112:8080/api/v1/contratarservico', data: {
      'origem': origem,
      'statusServico': statusServico,
      'dataServico': dataServico,
      'donoCarro': donoCarro,
      'servico': servico,
    });
  }
}
