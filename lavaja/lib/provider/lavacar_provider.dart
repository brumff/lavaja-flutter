import 'package:flutter/material.dart';
import 'package:lavaja/data/lavacar_service.dart';
import 'package:lavaja/provider/contratarservico_provider.dart';
import 'package:provider/provider.dart';

import '../models/lavacar.dart';

class LavacarProvider with ChangeNotifier {
  final LavacarService service;
  Lavacar? usuario;
  bool _isOpen = false;
  Map<String, String> _temposEspera = {};

  void setTempoEspera(String lavacarId, String tempo) {
    _temposEspera[lavacarId] = tempo;
    notifyListeners();
  }

  String? getTempoEspera(String lavacarId) {
    return _temposEspera[lavacarId];
  }


  bool get isOpen => _isOpen;

  LavacarProvider({required this.service}) {
    loadLavacar();
  }

  Future<void> getLavacar() async {
    usuario = await service.getLavacarByToken();
    notifyListeners();
  }

  int? getTempoFila(int index) {
    if (index >= 0 && index < lavacar.length) {
      return lavacar[index].tempFila;
    }
    return null;
  }

  List<Lavacar> lavacar = [];

  List<Lavacar> get all {
    return [...lavacar];
  }

  List<Lavacar> get user => lavacar;

  int get lavacarCount => lavacar.length;

  Lavacar? byIndex(int? i) {
    if (i == null) {
      return null;
    }
    return lavacar.elementAt(i);
  }

  Future<void> loadLavacar() async {
    lavacar = await service.getLavacarAberto();
    notifyListeners();
  }

  void createLavacar(
      String cnpj,
      String nome,
      String rua,
      String numero,
      String complemento,
      String bairro,
      String cidade,
      String cep,
      String longitude,
      String latitude,
      String telefone1,
      String telefone2,
      String email,
      String senha,
      String confSenha) async {
    final lavacar = await service.createLavacar(
        cnpj,
        nome,
        rua,
        numero,
        complemento,
        bairro,
        cidade,
        cep,
        longitude,
        latitude,
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
    String rua,
    String numero,
    String complemento,
    String bairro,
    String cidade,
    String cep,
    String longitude,
    String latitude,
    String telefone1,
    String telefone2,
    String email,
  ) async {
    await service.updateLavacar(cnpj, nome, rua, numero, complemento, bairro,
        cidade, cep, longitude, latitude, telefone1, telefone2, email);
    notifyListeners();
  }

  set isOpen(bool newValue) {
    _isOpen = newValue;
    notifyListeners();
  }

  Future<bool> abrirLavacar(bool aberto) async {
    final lavacar = await service.abrirLavacar(aberto);
    await loadLavacar();
    isOpen = aberto;
    return isOpen;
  }
}
