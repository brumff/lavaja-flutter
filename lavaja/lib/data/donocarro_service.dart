import 'package:dio/dio.dart';
import 'package:lavaja/data/auth_service.dart';
import 'package:lavaja/models/donocarro.dart';

class DonoCarroService {
  final Dio dio = Dio();

  Future<List<DonoCarro>> getDonoCarro() async {
    final response = await dio.get('http://localhost:8080/api/v1/donocarro');
    final data = response.data as List<dynamic>;
    return data.map((json) => DonoCarro.fromMap(json)).toList();
  }

  Future<DonoCarro> getDonoCarroByToken() async {
     dio.options.headers = {'authorization': AuthService.token};
    final response =
        await dio.get('http://localhost:8080/api/v1/donocarro/');
    final data = response.data;
    return DonoCarro.fromMap(data);
  }

  Future<void> createDonoCarro(String? nome, String? telefone, String? email,
      String? genero, String? senha, String? confSenha) async {
    await dio.post('http://localhost:8080/api/v1/donocarro', data: {
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'genero': genero,
      'senha': senha,
      'confSenha': confSenha
    });
  }

  Future<void> updateDonoCarro(String? nome, String? telefone, String? genero) async {
    dio.options.headers = {'authorization': AuthService.token};
    await dio.put(
      'http://localhost:8080/api/v1/donocarro/',
      data: {
        'nome': nome,
        'telefone': telefone,
        'genero': genero,
      },
    );
  }

  Future<void> deleteDonoCarro(int? id) async {
    await dio.delete('http://localhost:8080/api/v1/donocarro/$id');
  }
}
