import 'package:flutter/material.dart';
import 'package:lavaja/data/veiculo_service.dart';
import 'package:lavaja/models/veiculo.dart';

class VeiculoProvider with ChangeNotifier {
  final VeiculoService service;
  List<Veiculo> veiculos = [];
  Veiculo? veiculo;

  VeiculoProvider({required this.service}) {
    loadVeiculo();
  }

  Future<void>loadVeiculo() async {
    veiculos = await service.getListarVeiculos();
     notifyListeners();
  }
   Future<Veiculo?> getVeiculoById(String id) async {
    veiculo = await service.getVeiculoById(id);
    return veiculo;
  }
   Future<void> createVeiculo(String? marca, String? modelo, String? placa, String? cor) async {
    final veiculo =
        await service.createVeiculo(marca, modelo, placa, cor);
    notifyListeners();
  }
 Future<void> update(int id, String? marca, String? modelo, String? placa, String? cor) async {
    final veiculo = await service.updateVeiculo(
        id, marca, modelo, placa, cor);
    await loadVeiculo();
    notifyListeners();
  }
  Future<void> deletar(int? id) async {
   final veiculo = await service.deletarVeiculo(id);
     await loadVeiculo();
     notifyListeners();
  }
}