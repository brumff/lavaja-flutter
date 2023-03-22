import 'package:flutter/material.dart';
import 'package:lavaja/data/lavacar_service.dart';

import '../models/lavacar.dart';

class LavacarProvider with ChangeNotifier {
  final LavacarService service;

  LavacarProvider({required this.service}) {
    loadLavacar();
  }

  List<Lavacar> _lavacar = [];

  List<Lavacar> get all {
    return [..._lavacar];
  }

  List<Lavacar> get user => _lavacar;

  int get lavacarCount => _lavacar.length;

  Lavacar? byIndex(int? i) {
    if (i == null) {
      return null;
    }
    return _lavacar.elementAt(i);
  }

  Future<void> loadLavacar() async {
    _lavacar = await service.getLavacar();
    notifyListeners();
  }

  void createLavacat(
      String cnpj,
      String nome,
      String logradouro,
      String numero,
      String complemento,
      String bairro,
      String cidade,
      String cep,
      String telefone1,
      String telefone2,
      String email,
      bool ativo) async {
    final lavacar = await service.createLavacar(cnpj, nome, logradouro, numero,
        complemento, bairro, cidade, cep, telefone1, telefone2, email, ativo);
    await loadLavacar();
    notifyListeners();
  }

  //Terminar com felipe
  void updateLavacar(
      Lavacar lavacar,
      String cnpj,
      String nome,
      String logradouro,
      String numero,
      String complemento,
      String bairro,
      String cidade,
      String cep,
      String telefone1,
      String telefone2,
      String email,
      bool ativo) async {
    /*await service.updateUser(user.id, name, obs);
    user.name = name;
    user.obs = obs;*/
    notifyListeners();
  }

  void deleteLavacar(Lavacar lavacar) async {
    await service.deleteLavacar(lavacar.id);
    //carregar lista depois que excluir o usuário
    await loadLavacar();
    notifyListeners();
  }
}
