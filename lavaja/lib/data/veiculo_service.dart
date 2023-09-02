import 'package:dio/dio.dart';
import 'package:lavaja/models/veiculo.dart';

import 'auth_service.dart';

class VeiculoService {
  final Dio dio = Dio();

    Future<List<Veiculo>> getListarVeiculos() async {
    dio.options.headers = {'authorization': AuthService.token};
    final response =
        await dio.get('http://192.168.1.7:8080/api/v1/veiculo');
    final data = response.data as List<dynamic>;
    return data.map((json) => Veiculo.fromMap(json)).toList();
  }
Future<Veiculo> getVeiculoById(String id) async {
    final response = await dio.get('http://192.168.1.7:8080/api/v1/veiculo/$id');
    final data = response.data;
    return Veiculo.fromMap(data);
  }

  Future<void> createVeiculo(String? marca, String? modelo, String? placa, String? cor) async {

    await dio.post('http://192.168.1.7:8080/api/v1/veiculo', data: {
      'marca': marca,
      'modelo': modelo,
      'placa': placa,
      'cor': cor,
    });
  }
    Future<void> updateVeiculo(int id, String? marca, String? modelo, String? placa, String? cor) async {

    await dio.put('http://192.168.1.7:8080/api/v1/veiculo/$id', data: {
      'marca': marca,
      'modelo': modelo,
      'placa': placa,
      'cor': cor,
     
    });
  }

   Future<void> deletarVeiculo(int? id) async {
    dio.options.headers = {'authorization': AuthService.token};
    await dio.delete('http://192.168.1.7:8080/api/v1/veiculo/$id');
  }
}