import 'package:dio/dio.dart';
import 'package:lavaja/data/auth_service.dart';
import 'package:lavaja/models/donocarro.dart';

class DonoCarroService {
  final Dio dio = Dio();

  Future<List<DonoCarro>> getDonoCarro() async {
    dio.options.headers = {'authorization': AuthService.token};
    final response = await dio.get('http://192.168.1.20:8080/api/v1/donocarro/');
    final data = response.data as List<dynamic>;
    return data.map((json) => DonoCarro.fromMap(json)).toList();
  }

  Future<DonoCarro> getDonoCarroByToken() async {
    dio.options.headers = {'authorization': AuthService.token};
    final response =
        await dio.get('http://192.168.1.20:8080/api/v1/donocarro/');
    final data = response.data;
    return DonoCarro.fromMap(data);
  }

  Future<String> createDonoCarro(String? nome, String? cpf, String? telefone,
      String? email, String? genero, String? senha, String? confSenha) async {
    try {
      final response =
          await dio.post('http://192.168.1.20:8080/api/v1/donocarro', data: {
        'nome': nome,
        'cpf': cpf,
        'telefone': telefone,
        'email': email,
        'genero': genero,
        'senha': senha,
        'confSenha': confSenha
      });

      if (response.statusCode == 200) {
        return 'Cadastro realizado com sucesso!';
      } else {
        return 'Erro ao cadastrar: ${response.data}';
      }
    } on DioError catch (e) {
      if (e.response != null) {
        return 'Erro no backend: ${e.response!.data}';
      }
      return 'Erro no Dio: $e';
    }
  }

  Future<void> updateDonoCarro(
      String? nome, String? cpf, String? telefone, String? genero) async {
    dio.options.headers = {'authorization': AuthService.token};
    await dio.put(
      'http://192.168.1.20:8080/api/v1/donocarro/',
      data: {
        'nome': nome,
        'cpf': cpf,
        'telefone': telefone,
        'genero': genero,
      },
    );
  }

  Future<void> deleteDonoCarro(int? id) async {
    await dio.delete('http://192.168.1.20:8080/api/v1/donocarro/$id');
  }

  Future<void> tokenFirebase(String? tokenFirebase) async {
    dio.options.headers = {'authorization': AuthService.token};
    await dio.put(
      'http://192.168.1.20:8080/api/v1/donocarro/tokenfirebase',
      data: {
        'tokenFirebase': tokenFirebase
      },
    );
  }
}
