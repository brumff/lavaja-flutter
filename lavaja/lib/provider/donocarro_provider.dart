import 'package:flutter/material.dart';
import 'package:lavaja/data/donocarro_service.dart';

import '../models/donocarro.dart';

class DonoCarroProvider with ChangeNotifier {
  final DonoCarroService service;

  DonoCarroProvider({required this.service}) {
    loadDonoCarro();
  }

  /*Future<void> getDonoCarro() async {
    donoCarro =  await service.getDonoCarroById(id);
    notifyListeners();
  }*/
  List<DonoCarro> _donoCarro = [];

  Future<void> loadDonoCarro() async {
    _donoCarro = await service.getDonoCarro();
    notifyListeners();
  }

  void createDonoCarro(String nome, String telefone, String genero,
      String email, String senha, String confSenha) async {
    final donocarro = await service.createDonoCarro(
        nome, telefone, genero, email, senha, confSenha);
    await loadDonoCarro();
    notifyListeners();
  }

  //Terminar com felipe
  void updateDonoCarro(String nome, String telefone, String email,
      String genero, String senha, String confSenha) async {
    /*await service.updateUser(user.id, name, obs);
    user.name = name;
    user.obs = obs;*/
    notifyListeners();
  }

  void deleteDonoCarro(DonoCarro donocarro) async {
    await service.deleteDonoCarro(donocarro.id);
    //carregar lista depois que excluir o usuário
    await loadDonoCarro();
    notifyListeners();
  }


}
