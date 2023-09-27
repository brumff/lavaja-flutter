import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/models/contratarservico.dart';
import 'package:lavaja/models/servico.dart';

class ContratarServicoDonocarroProvider with ChangeNotifier {
  final ContratarServicoService service;
  List<ContratarServico> contratarServico = [];

  ContratarServicoDonocarroProvider({required this.service}) {
    loadContratarServicoDonocarro();
  }

  Future<void> loadContratarServicoDonocarro() async {
    contratarServico = await service.getListarServicosDonocarro();
    notifyListeners();
  }

  void toggleExpanded(int index) {
    contratarServico[index].isExpanded = contratarServico[index].isExpanded;
    notifyListeners();
  }


}

