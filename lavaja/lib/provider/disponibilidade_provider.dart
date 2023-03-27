import 'package:flutter/material.dart';
import 'package:lavaja/data/lavacar_service.dart';

import '../data/disponibilidade_service.dart';
import '../models/disponibilidade.dart';
import '../models/lavacar.dart';

class DisponibilidadeProvider with ChangeNotifier {
  final DisponibilidadeService service;

  DisponibilidadeProvider({required this.service}) {
    loadDisponibilidade();
  }

  List<Disponibilidade> _disponibilidade = [];

  List<Disponibilidade> get all {
    return [..._disponibilidade];
  }

  List<Disponibilidade> get user => _disponibilidade;

  int get disponibilidadeCount => _disponibilidade.length;

  Disponibilidade? byIndex(int? i) {
    if (i == null) {
      return null;
    }
    return _disponibilidade.elementAt(i);
  }

  Future<void> loadDisponibilidade() async {
    _disponibilidade = await service.getDisponibilidade();
    notifyListeners();
  }

  void createDisponibilidade(
    int id,
    bool seg,
    bool ter,
    bool qua,
    bool qui,
    bool sex,
    bool sab,
    bool dom,
    TimeOfDay? abre,
    TimeOfDay? fecha,
  ) async {
    final disponibilidade = await service.createDisponibilidade(
        id, seg, ter, qua, qui, sex, sab, dom, abre, fecha);
    await loadDisponibilidade();
    notifyListeners();
  }

  //Terminar com felipe
  void updateDisponibilidade(
      Disponibilidade disponibilidade,
      bool seg,
      bool ter,
      bool qua,
      bool qui,
      bool sex,
      bool sab,
      bool dom,
      TimeOfDay abre,
      TimeOfDay fecha,
      o) async {
    /*await service.updateUser(user.id, name, obs);
    user.name = name;
    user.obs = obs;*/
    notifyListeners();
  }

  void deleteDisponibilidade(Disponibilidade disponibilidade) async {
    await service.deleteDisponibilidade(disponibilidade.id);
    //carregar lista depois que excluir o usuário
    await loadDisponibilidade();
    notifyListeners();
  }
}
