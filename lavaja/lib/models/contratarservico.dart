import 'dart:convert';

class ContratarServico {
  int? id;
  String? origem;
  String? statusServico;
  String? dataServico;
  int? donoCarro;
  int? servico;
  int? tempFila;

  ContratarServico(
      {this.id,
      this.origem,
      this.statusServico,
      this.dataServico,
      this.donoCarro,
      this.servico,
      this.tempFila});

  factory ContratarServico.fromMap(Map<String, dynamic> map) {
    return ContratarServico(
        id: map['id'],
        origem: map['origem'],
        statusServico: map['statusServico'],
        dataServico: map['dataServico'],
        donoCarro: map['donoCarro'],
        servico: map['servico'],
        tempFila: map['tempFila']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'origem': origem,
      'statusServico': statusServico,
      'dataServico': dataServico,
      'donoCarro': dataServico,
      'servico': servico,
      'tempFila': tempFila
    };
  }

  String toJson() => json.encode(toMap());
}
