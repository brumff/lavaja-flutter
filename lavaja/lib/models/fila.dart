import 'dart:convert';

class Fila {
    int? id;
    String? origem;
    String? statusServico;
    DateTime? dataServico;
    int? donoCarro;
    int? servico;

    Fila({this.id, this.dataServico, this.donoCarro, this.origem, this.servico, this.statusServico});

    factory Fila.fromMap(Map<String, dynamic> map) {
      return Fila(
        id: map['id'],
        origem: map['origem'],
        statusServico: map['statusServico'],
        dataServico: map['dataServico'],
        donoCarro: map['donoCarro'],
        servico: map['servico']
      );
    }

    Map<String, dynamic> toMap(){
      return  {
        'id': id,
        'origem': origem,
        'statusServico': statusServico,
        'dataServico': dataServico,
        'donoCarro': donoCarro,
        'servico': servico
      };
    }

    String toJson() => json.encode(toMap());
}