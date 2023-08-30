import 'package:flutter/material.dart';
import 'package:lavaja/data/donocarro_service.dart';

import '../models/donocarro.dart';

class DonoCarroProvider with ChangeNotifier {
  final DonoCarroService service;
  DonoCarro? usuario;

  DonoCarroProvider({required this.service}) {
    loadDonoCarro();
  }

  Future<void> getDonoCarro() async {
    usuario = await service.getDonoCarroByToken();
    notifyListeners();
  }

  List<DonoCarro> _donoCarro = [];

  Future<void> loadDonoCarro() async {
    _donoCarro = await service.getDonoCarro();
    notifyListeners();
  }

  void createDonoCarro(String nome, String cpf, String telefone, String genero,
      String email, String senha, String confSenha) async {
    final donocarro = await service.createDonoCarro(
        nome, cpf, telefone, genero, email, senha, confSenha);
    await loadDonoCarro();
    notifyListeners();
  }

  void updateDonoCarro(
      String nome, String cpf, String telefone, String genero) async {
    await service.updateDonoCarro(nome, cpf, telefone, genero);
    notifyListeners();
  }

  void deleteDonoCarro(DonoCarro donocarro) async {
    await service.deleteDonoCarro(donocarro.id);
    //carregar lista depois que excluir o usuário
    await loadDonoCarro();
    notifyListeners();
  }
}
