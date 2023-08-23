import 'dart:convert';

class Servico{
   
     int? id;
     String? nome;
     double? valor;
     String? tamCarro;
     int? tempServico;
     bool? ativo;
     int? lavacarId;

     Servico({this.id, this.nome, this.valor, this.tamCarro, this.tempServico, this.ativo, this.lavacarId});

     factory Servico.fromMap(Map<String, dynamic> map) {
      return Servico(
        id: map['id'],
        nome: map['nome'],
        valor: map['valor'],
        tamCarro: map['tamCarro'],
        tempServico: map['tempServico'],
        ativo: map['ativo'],
        lavacarId: map['lavacarId'],
      );
     }

     Map<String, dynamic> toMap(){
      return{
        'id': id,
        'nome': nome,
        'valor': valor,
        'tamCarro': tamCarro,
        'tempServico': tempServico,
        'ativo': ativo,
        'lavacarId': lavacarId,
      };
     }

     String toJson() => json.encode(toMap());
}