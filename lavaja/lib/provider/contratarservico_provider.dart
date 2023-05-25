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
}
