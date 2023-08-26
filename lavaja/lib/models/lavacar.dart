import 'dart:convert';

class Lavacar {
  int? id;
  //imagem
  String? cnpj;
  String? nome;
  String? rua;
  String? numero;
  String? bairro;
  String? cidade;
  String? cep;
  double? latitude;
  double? longitude;
  String? telefone1;
  String? telefone2;
  String? email;
  String? senha;
  String? confSenha;
  double? tempoFila;
  double? distancia;
  bool? aberto;

  // ver como fazer a parte da disponibilidade
  Lavacar(
      {this.id,
      this.cnpj,
      this.nome,
      this.rua,
      this.numero,
      this.bairro,
      this.cidade,
      this.cep,
      this.latitude,
      this.longitude,
      this.telefone1,
      this.telefone2,
      this.email,
      this.senha,
      this.confSenha,
      this.tempoFila,
      this.distancia,
      this.aberto});

  factory Lavacar.fromMap(Map<String, dynamic> map) {
    return Lavacar(
        id: map['id'],
        cnpj: map['cnpj'],
        nome: map['nome'],
        rua: map['rua'],
        numero: map['numero'],
        bairro: map['bairro'],
        cidade: map['cidade'],
        cep: map['cep'],
        latitude: map['latitude'],
        longitude: map['longitude'],
        telefone1: map['telefone1'],
        telefone2: map['telefone2'],
        email: map['email'],
        senha: map['senha'],
        confSenha: map['confSenha'],
        tempoFila: map['tempoFila'],
        aberto: map['aberto']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cnpj': cnpj,
      'nome': nome,
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'cep': cep,
      'latitude': latitude,
      'longitude': longitude,
      'telefone1': telefone1,
      'telefone2': telefone2,
      'email': email,
      'senha': senha,
      'confSenha': confSenha,
      'tempoFila': tempoFila,
      'aberto': aberto
    };
  }

  String toJson() => json.encode(toMap());

}
