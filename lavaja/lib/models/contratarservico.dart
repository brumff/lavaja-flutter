import 'dart:convert';
import 'dart:ffi';

import 'package:lavaja/models/donocarro.dart';
import 'package:lavaja/models/servico.dart';
import 'package:lavaja/models/veiculo.dart';

class ContratarServico {
  int? id;
  String? origem;
  String? statusServico;
  String? dataContratacaoServico;
  String? dataPrevisaoServico;
  String? atrasado;
  String? dataFinalServico;
  int? donoCarroId;
  Servico? servicoId;
  Veiculo? veiculoId;
  String? placaCarro;
  bool? deleted;
  String? telefone;
  double? tempFila;
  int? minutosAdicionais;
  bool? isExpanded;

  ContratarServico({
    this.id,
    this.origem,
    this.statusServico,
    this.dataContratacaoServico,
    this.dataPrevisaoServico,
    this.atrasado,
    this.dataFinalServico,
    this.donoCarroId,
    this.servicoId,
    this.veiculoId,
    this.placaCarro,
    this.deleted,
    this.telefone,
    this.tempFila,
    this.minutosAdicionais,
    this.isExpanded
  });

  factory ContratarServico.fromMap(Map<String, dynamic> map) {
    return ContratarServico(
      id: map['id'],
      origem: map['origem'],
      statusServico: map['statusServico'],
      dataContratacaoServico: map['dataContratacaoServico'],
      dataPrevisaoServico: map['dataPrevisaoServico'],
      atrasado: map['atrasado'],
      dataFinalServico: map['dataFinalServico'],
      donoCarroId: map['donoCarroId'],
      servicoId:Servico.fromMap(map['servicoId']), 
      veiculoId: map['veiculoId'] != null ? Veiculo.fromMap(map['veiculoId']) : null,
      placaCarro: map['placaCarro'],
      deleted: map['deleted'],
      telefone: map['telefone'],
      tempFila: map['tempFila'], 
      minutosAdicionais: map['minutosAdicionais'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'origem': origem,
      'statusServico': statusServico,
      'dataContratacaoServico': dataContratacaoServico,
      'dataPrevisaoServico': dataPrevisaoServico,
      'atrasado': atrasado,
      'dataFinalServico': dataFinalServico,
      'donoCarroId': donoCarroId,
      'servicoId': servicoId, 
      'veiculoId': veiculoId, 
      'placaCarro': placaCarro,
      'deleted': deleted,
      'telefone': telefone,
      'tempFila': tempFila,
      'minutosAdicionais': minutosAdicionais,
    };
  }

  String toJson() => json.encode(toMap());
}
