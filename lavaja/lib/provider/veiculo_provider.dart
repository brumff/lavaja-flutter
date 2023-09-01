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

   void createVeiculo(String? marca, String? modelo, String? placa, String? cor, int? donoCarroModel, bool? deleted) async {
    final veiculo =
        await service.createVeiculo(marca, modelo, placa, cor, donoCarroModel, deleted);
    notifyListeners();
  }
  void update(String id, String? marca, String? modelo, String? placa, String? cor, int? donoCarroModel) async {
    final veiculo = await service.updateVeiculo(
        id, marca, modelo, placa, cor, donoCarroModel);
    await loadVeiculo();
    notifyListeners();
  }
  
}