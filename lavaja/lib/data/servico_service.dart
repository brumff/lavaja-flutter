import 'package:dio/dio.dart';
import 'package:lavaja/data/prefs_service.dart';
import 'package:lavaja/main.dart';

import '../models/servico.dart';
import 'auth_service.dart';

class ServicoService {
  final Dio dio = Dio();
  String ip = MyApp.ip;

  //ativos e inativos
  Future<List<Servico>> getServico() async {
    final response = await dio.get('${ip}/api/v1/servico');
    final data = response.data as List<dynamic>;
    return data.map((json) => Servico.fromMap(json)).toList();
  }

  //Somente ativos
  Future<List<Servico>> getServicosAtivos() async {
    final response = await dio.get('${ip}/api/v1/servico/ativos');
    final data = response.data as List<dynamic>;
    return data.map((json) => Servico.fromMap(json)).toList();
  }

  Future<List<Servico>> getListarServicosLavacarLogado() async {
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
    final response = await dio.get('${ip}/api/v1/servico/meus-servicos');
    final data = response.data as List<dynamic>;
    return data.map((json) => Servico.fromMap(json)).toList();
  }

  Future<Servico> getServicoById(String id) async {
    final response = await dio.get('${ip}/api/v1/servico/$id');
    final data = response.data;
    return Servico.fromMap(data);
  }

  Future<void> createServico(
      String? nome, double? valor, double? tempServico, bool? ativo) async {
    await dio.post('${ip}/api/v1/servico', data: {
      'nome': nome,
      'valor': valor,
      'tempServico': tempServico,
      'ativo': ativo,
    });
  }

  Future<void> updateServico(String id, String? nome, double? valor,
      double? tempServico, bool? ativo) async {
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
    await dio.put('${ip}/api/v1/servico/$id', data: {
      'nome': nome,
      'valor': valor,
      'tempServico': tempServico,
      'ativo': ativo,
    });
  }
}
