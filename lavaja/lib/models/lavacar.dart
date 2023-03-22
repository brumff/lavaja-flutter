import 'dart:convert';

class Lavacar {
  final int? id;
  //imagem
  final String? cnpj;
  final String? nome;
  final String? logradouro;
  final String? numero;
  final String? complemento;
  final String? bairro;
  final String? cidade;
  final String? cep;
  final String? telefone1;
  final String? telefone2;
  final String? email;
  final bool? ativo;
// ver como fazer a parte da disponibilidade
  const Lavacar(
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
      'ativo': ativo,
    };
  }

  String toJson() => json.encode(toMap());
}
