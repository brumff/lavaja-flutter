import 'dart:convert';

import 'package:lavaja/models/servico.dart';

class ContratarServico {
  int? id;
  String? origem;
  String? statusServico;
  String? dataServico;
  int? donoCarro;
  Servico? servico;
  int? tempFila;
  String? placaCarro;
  DateTime? fimLavagem;
  bool? isExpanded;
  String? telefone;

  ContratarServico(
      {this.id,
      this.origem,
      this.statusServico,
      this.dataServico,
      this.donoCarro,
      this.servico,
      this.tempFila,
      this.placaCarro,
      this.fimLavagem, 
      this.isExpanded,
      this.telefone});

  factory ContratarServico.fromMap(Map<String, dynamic> map) {
    return ContratarServico(
        id: map['id'],
        origem: map['origem'],
        statusServico: map['statusServico'],
        dataServico: map['dataServico'],
        donoCarro: map['donoCarro'],
        servico: Servico.fromMap(map['servicoId']),
        tempFila: map['tempFila'],
        placaCarro: map['placaCarro'],
        telefone:map['telefone']);
        
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'origem': origem,
      'statusServico': statusServico,
      'dataServico': dataServico,
      'donoCarro': dataServico,
      'servico': servico,
      'tempFila': tempFila,
      'placaCarro': placaCarro,
      'telefone': telefone
    };
  }

  String toJson() => json.encode(toMap());
}
