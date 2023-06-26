import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/models/contratarservico.dart';

class ContratarServicoProvider with ChangeNotifier {
  final ContratarServicoService service;
  List<ContratarServico> contratarServico = [];

  ContratarServicoProvider({required this.service}) {
    loadContratarServico();
  }

  Future<void> loadContratarServico() async {
    contratarServico = await service.getListarServicosLavacar();
    notifyListeners();
  }

  void toggleExpanded(int index) {
    contratarServico[index].isExpanded = contratarServico[index].isExpanded;
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
