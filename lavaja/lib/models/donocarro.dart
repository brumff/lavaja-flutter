import 'dart:convert';

class DonoCarro {
  int? id;
  String? nome;
  String? cpf;
  String? telefone;
  String? email;
  String? genero;
  String? senha;
  String? confSenha;
  String? perfis;
  String? tokenFirebase;

  DonoCarro(
      {this.id,
      this.nome,
      this.cpf,
      this.telefone,
      this.email,
      this.genero,
      this.senha,
      this.confSenha,
      this.perfis,
      this.tokenFirebase});

  factory DonoCarro.fromMap(Map<String, dynamic> map) {
    return DonoCarro(
        id: map['id'],
        nome: map['nome'],
        cpf: map['cpf'],
        telefone: map['telefone'],
        email: map['email'],
        genero: map['genero'],
        senha: map['senha'],
        confSenha: map['confSenha'],
        perfis: map['perfis'],
        tokenFirebase: map['tokebFirebase']
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
      'email': email,
      'genero': genero,
      'senha': senha,
      'confSenha': confSenha,
      'perfis': perfis,
      'tokenFirebase': tokenFirebase
    };
  }

  String toJson() => json.encode(toMap());
}
