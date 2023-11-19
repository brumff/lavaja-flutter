import 'package:dio/dio.dart';
import 'package:lavaja/data/prefs_service.dart';
import 'package:lavaja/main.dart';
import 'package:lavaja/models/veiculo.dart';

import 'auth_service.dart';

class VeiculoService {
  final Dio dio = Dio();
  String ip = MyApp.ip;

  Future<List<Veiculo>> getListarVeiculos() async {
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
    final response = await dio.get('${ip}/api/v1/veiculo');
    final data = response.data as List<dynamic>;
    return data.map((json) => Veiculo.fromMap(json)).toList();
  }

  Future<Veiculo> getVeiculoById(String id) async {
    final response = await dio.get('${ip}/api/v1/veiculo/$id');
    final data = response.data;
    return Veiculo.fromMap(data);
  }

  Future<void> createVeiculo(
      String? marca, String? modelo, String? placa, String? cor) async {
    await dio.post('${ip}/api/v1/veiculo', data: {
      'marca': marca,
      'modelo': modelo,
      'placa': placa,
      'cor': cor,
    });
  }

  Future<void> updateVeiculo(
      int id, String? marca, String? modelo, String? placa, String? cor) async {
    await dio.put('${ip}/api/v1/veiculo/$id', data: {
      'marca': marca,
      'modelo': modelo,
      'placa': placa,
      'cor': cor,
    });
  }

  Future<String> deletarVeiculo(int? id) async {
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
    try {
      final response = await dio.delete('${ip}/api/v1/veiculo/$id');

      if (response.statusCode == 200) {
        return 'Veículo excluido com sucesso!';
      } else {
        return 'Erro ao exlcuir veículo!';
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Map<String, dynamic> errorResponse = e.response!.data;
        if (errorResponse.containsKey("message")) {
          String errorMessage = errorResponse["message"];
          print(errorMessage);
          return '$errorMessage';
        }
      }
      return 'Erro no Dio: $e';
    }
  }
}
