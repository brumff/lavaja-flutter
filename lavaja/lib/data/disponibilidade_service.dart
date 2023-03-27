import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/disponibilidade.dart';
import '../models/lavacar.dart';

class DisponibilidadeService {
  final Dio dio = Dio();

  Future<List<Disponibilidade>> getDisponibilidade() async {
    final response = await dio.get('http://localhost:8080/api/v1/lavacar');
    final data = response.data as List<dynamic>;
    return data.map((json) => Disponibilidade.fromMap(json)).toList();
  }

  //Verificar com o felipe se está correto dessa forma e como chamar a parte dos horarios
  Future<void> createDisponibilidade(
      int? id,
      bool? seg,
      bool? ter,
      bool? qua,
      bool? qui,
      bool? sex,
      bool? sab,
      bool? dom,
      TimeOfDay? abre,
      TimeOfDay? fecha,
) async {
    await dio.post('http://localhost:8080/api/v1/lavacar', data: {
      'seg': seg,
      'ter': ter,
      'qua': qua,
      'qui': qui,
      'sex': sex,
      'sab': sab,
      'dom': dom,
      'abre': abre,
      'fecha': fecha
    });
  }

  Future<void> updateDisponibilidade(
      int? id,
      bool? seg,
      bool? ter,
      bool? qua,
      bool? qui,
      bool? sex,
      bool? sab,
      bool? dom,
      TimeOfDay? abre,
      TimeOfDay? fecha,) async {
    await dio.put('http://localhost:8080/api/v1/lavacar/$id', data: {
      'seg': seg,
      'ter': ter,
      'qua': qua,
      'qui': qui,
      'sex': sex,
      'sab': sab,
      'dom': dom,
      'abre': abre,
      'fecha': fecha
    });
  }

  Future<void> deleteDisponibilidade(int? id) async {
    await dio.delete('http://localhost:8080/api/v1/lavacar/$id');
  }
}
