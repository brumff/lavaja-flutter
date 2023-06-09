import 'dart:convert';

class DonoCarro {
  int? id;
  String? nome;
  String? telefone;
  String? email;
  String? genero;
  String? senha;
  String? confSenha;
  String? perfis;

  DonoCarro(
      {this.id,
      this.nome,
      this.telefone,
      this.email,
      this.genero,
      this.senha,
      this.confSenha, 
      this.perfis});

  factory DonoCarro.fromMap(Map<String, dynamic> map) {
    return DonoCarro(
      id: map['id'],
      nome: map['nome'],
      telefone: map['telefone'],
      email: map['email'],
      genero: map['genero'],
      senha: map['senha'],
      confSenha: map['confSenha'],
      perfis: map['perfis']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'genero': genero,
      'senha': senha,
      'confSenha': confSenha,
      'perfis': perfis
    };
  }

  String toJson() => json.encode(toMap());
}
