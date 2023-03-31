import 'package:dio/dio.dart';
import 'package:lavaja/models/donocarro.dart';

class DonoCarroService {
  final Dio dio = Dio();

  Future<List<DonoCarro>> getDonoCarro() async {
    final response = await dio.get('http://localhost:8080/api/v1/donocarro');
    final data = response.data as List<dynamic>;
    return data.map((json) => DonoCarro.fromMap(json)).toList();
  }

  Future<DonoCarro> getDonoCarroById(String id) async {
    final response =
        await dio.get('http://localhost:8080/api/v1/donocarro/$id');
    final data = response.data;
    return DonoCarro.fromMap(data);
  }

  Future<void> createDonoCarro(String? nome, String? telefone,
      String? email, String? genero, String? senha, String? confSenha) async {
    await dio.post('http://localhost:8080/api/v1/donocarro', data: {
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'genero': genero,
      'senha': senha,
      'confSenha': confSenha
    });
  }

  Future<void> updateDonoCarro(String? id, String? nome, String? telefone,
      String? email, String? genero, String? senha, String? confSenha) async {
    await dio.post('http://localhost:8080/api/v1/donocarro/$id', data: {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'genero': genero,
      'senha': senha,
      'confSenha': confSenha
    });
  }

  Future<void> deleteDonoCarro(int? id) async {
    await dio.delete('http://localhost:8080/api/v1/donocarro/$id');
  }
}
