import 'package:flutter/material.dart';
import 'package:lavaja/data/lavacar_service.dart';

import '../models/lavacar.dart';

class LavacarProvider with ChangeNotifier {
  final LavacarService service;
  Lavacar? usuario;

  LavacarProvider({required this.service}) {
    loadLavacar();
  }

  Future<void> getLavacar() async {
    usuario = await service.getLavacarByToken();
    notifyListeners();
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

  void createLavacar(
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
      String senha,
      String confSenha) async {
    final lavacar = await service.createLavacar(
        cnpj,
        nome,
        logradouro,
        numero,
        complemento,
        bairro,
        cidade,
        cep,
        telefone1,
        telefone2,
        email,
        senha,
        confSenha);
    await loadLavacar();
    notifyListeners();
  }

  void updateLavacar(
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
      ) async {
    await service.updateLavacar(cnpj, nome, logradouro, numero, complemento, bairro, cidade, cep, telefone1, telefone2, email);
    notifyListeners();
  }

  void deleteLavacar(Lavacar lavacar) async {
    await service.deleteLavacar(lavacar.id);
    //carregar lista depois que excluir o usuário
    await loadLavacar();
    notifyListeners();
  }
}

