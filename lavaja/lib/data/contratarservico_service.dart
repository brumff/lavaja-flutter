import 'package:dio/dio.dart';
import 'package:lavaja/data/prefs_service.dart';
import 'package:lavaja/main.dart';
import 'package:lavaja/models/contratarservico.dart';
import 'package:lavaja/models/servico.dart';

import 'auth_service.dart';

class ContratarServicoService {
  final Dio dio = Dio();
  String ip = MyApp.ip;

  Future<List<ContratarServico>> getListarServicosLavacar() async {
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
    final response =
        await dio.get('${ip}/api/v1/contratarservico/lavacar-servicos');
    final data = response.data as List<dynamic>;

    return data.map((json) => ContratarServico.fromMap(json)).toList();
  }

  Future<List<ContratarServico>> getListarServicosDonocarro() async {
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
    final response =
        await dio.get('${ip}/api/v1/contratarservico/donocarro-servicos');
    final data = response.data as List<dynamic>;
    return data.map((json) => ContratarServico.fromMap(json)).toList();
  }

  Future<void> patchContratarServico(
      int? id, String? statusServico, int? minutosAdicionais) async {
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
    await dio.patch(
      '${ip}/api/v1/contratarservico/$id',
      data: {
        'statusServico': statusServico,
        'minutosAdicionais': minutosAdicionais,
      },
    );
  }

  Future<void> deletarContratarServico(int? id) async {
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
    await dio.delete('${ip}/api/v1/contratarservico/$id');
  }

  Future<void> createContratarServico(String? origem, String? placaCarro,
      int? servicoId, String? telefone) async {
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
    await dio.post(
      '${ip}/api/v1/contratarservico',
      data: {
        'origem': origem,
        'placaCarro': placaCarro,
        'servico': {'id': servicoId},
        'telefone': telefone
      },
    );
  }

  Future<void> createContratarServicoDonoCarro(
      String? origem, int? servicoId, int? veiculo) async {
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
    await dio.post(
      '${ip}/api/v1/contratarservico/donocarro',
      data: {
        'origem': origem,
        'servico': {'id': servicoId},
        'veiculo': {'id': veiculo},
      },
    );
  }

  Future<String> getTokenFirebase(String id) async {
    final response = await dio.get('${ip}/api/v1/servico/$id');
    final data = response.data;
    final token = data as String;
    return token;
  }

  Future<String> getShedule() async {
    final response =
        await dio.get('${ip}/api/v1/contratarservico/atualizar-tempo-espera');
    final data = response.data;

    return data;
  }
}
