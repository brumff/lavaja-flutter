import 'dart:convert';

import 'package:lavaja/models/donocarro.dart';

class Veiculo {
  int? id;
  String? marca;
  String? modelo;
  String? placa;
  String? cor;
  DonoCarro? donoCarroModel;
  bool? deleted;

  Veiculo(
      {this.id,
      this.marca,
      this.modelo,
      this.placa,
      this.cor,
      this.donoCarroModel,
      this.deleted});

  factory Veiculo.fromMap(Map<String, dynamic> map) {
    return Veiculo(
      id: map['id'],
      marca: map['marca'],
      modelo: map['modelo'],
      placa: map['placa'],
      cor: map['cor'],
     // donoCarroModel: map['donoCarroModel'],
      deleted: map['deleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'placa': placa,
      'cor': cor,
      //'donoCarroModel': donoCarroModel,
      'deleted': deleted,
    };
  }

  String toJson() => json.encode(toMap());
}
