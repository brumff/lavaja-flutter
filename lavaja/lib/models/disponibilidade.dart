import 'dart:convert';

import 'package:flutter/material.dart';

class Disponibilidade {
  final int? id;
  final bool? seg;
  final bool? ter;
  final bool? qua;
  final bool? qui;
  final bool? sex;
  final bool? sab;
  final bool? dom;
  final TimeOfDay? abre;
  final TimeOfDay? fecha;
// ver como fazer a parte da disponibilidade
  const Disponibilidade(
      {this.id,
      this.seg,
      this.ter,
      this.qua,
      this.qui,
      this.sex,
      this.sab,
      this.dom,
      this.abre,
      this.fecha});

  factory Disponibilidade.fromMap(Map<String, dynamic> map) {
    return Disponibilidade(
      id: map['id'],
      seg: map['seg'],
      ter: map['ter'],
      qua: map['qua'],
      qui: map['qui'],
      sex: map['sex'],
      sab: map['sab'],
      dom: map['dom'],
      abre: map['abre'],
      fecha: map['fecha'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'seg': seg,
      'ter': ter,
      'qua': qua,
      'qui': qui,
      'sex': sex,
      'sab': sab,
      'dom': dom,
      'abre': abre,
      'fecha': fecha
    };
  }

  String toJson() => json.encode(toMap());
}
