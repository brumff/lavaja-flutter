import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/models/contratarservico.dart';

class ContratarServicoProvider with ChangeNotifier {
  final ContratarServicoService service;

  ContratarServicoProvider({required this.service}) {
    loadContratarServico();
  }

  List<ContratarServico> contratarServico = [];

  Future<void> loadContratarServico() async {
    contratarServico = await service.getListarServicosLavacar();
    notifyListeners();
  }

  void patchContratarServico(int? id, String? statusServico) async {
    await service.patchContratarServico(id, statusServico);
    notifyListeners();
  }

  void deletarContratarServico(int? id) async {
    await service.deletarContratarServico(id);
    notifyListeners();
  }

}
