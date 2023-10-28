import 'package:dio/dio.dart';
import 'package:lavaja/data/auth_service.dart';
import 'package:lavaja/main.dart';
import 'package:lavaja/models/donocarro.dart';

class DonoCarroService {
  final Dio dio = Dio();
   String ip = MyApp.ip;

  Future<List<DonoCarro>> getDonoCarro() async {
    dio.options.headers = {'authorization': AuthService.token};
    final response =
        await dio.get('${ip}/api/v1/donocarro/');
    final data = response.data as List<dynamic>;
    return data.map((json) => DonoCarro.fromMap(json)).toList();
  }

  Future<DonoCarro> getDonoCarroByToken() async {
    dio.options.headers = {'authorization': AuthService.token};
    final response =
        await dio.get('${ip}/api/v1/donocarro/');
    final data = response.data;
    return DonoCarro.fromMap(data);
  }

Future<String> createDonoCarro(String? nome, String? cpf, String? telefone,
      String? email, String? genero, String? senha, String? confSenha) async {
  try {
    final response = await dio.post('${ip}/api/v1/donocarro', data: {
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

  Future<void> updateDonoCarro(
      String? nome, String? cpf, String? telefone, String? genero) async {
    dio.options.headers = {'authorization': AuthService.token};
    await dio.put(
      '${ip}/api/v1/donocarro/',
      data: {
        'nome': nome,
        'cpf': cpf,
        'telefone': telefone,
        'genero': genero,
      },
    );
  }

  Future<void> deleteDonoCarro(int? id) async {
    await dio.delete('${ip}/api/v1/donocarro/$id');
  }

  Future<void> tokenFirebase(String? tokenFirebase) async {
    dio.options.headers = {'authorization': AuthService.token};
    await dio.put(
      '${ip}/api/v1/donocarro/tokenfirebase',
      data: {'tokenFirebase': tokenFirebase},
    );
  }
}
