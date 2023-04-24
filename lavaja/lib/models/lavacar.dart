import 'dart:convert';

class Lavacar {
  int? id;
  //imagem
  String? cnpj;
  String? nome;
  String? logradouro;
  String? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? cep;
  String? telefone1;
  String? telefone2;
  String? email;
  String? senha;
  String? confSenha;
  bool? ativo;

// ver como fazer a parte da disponibilidade
  Lavacar(
      {this.id,
      this.cnpj,
      this.nome,
      this.logradouro,
      this.numero,
      this.complemento,
      this.bairro,
      this.cidade,
      this.cep,
      this.telefone1,
      this.telefone2,
      this.email,
      this.senha,
      this.confSenha,
      this.ativo});

  factory Lavacar.fromMap(Map<String, dynamic> map) {
    return Lavacar(
      id: map['id'],
      cnpj: map['cnpj'],
      nome: map['nome'],
      logradouro: map['logradouro'],
      numero: map['numero'],
      complemento: map['complemento'],
      bairro: map['bairro'],
      cidade: map['cidade'],
      cep: map['cep'],
      telefone1: map['telefone1'],
      telefone2: map['telefone2'],
      email: map['email'],
      senha: map['senha'],
      confSenha: map['confSenha'],
      ativo: map['ativo'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cnpj': cnpj,
      'nome': nome,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'telefone1': telefone1,
      'telefone2': telefone2,
      'email': email,
      'senha': senha,
      'confSenha': confSenha,
      'ativo': ativo,
    };
  }

  String toJson() => json.encode(toMap());
}
