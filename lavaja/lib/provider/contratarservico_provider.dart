import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/models/contratarservico.dart';
import 'package:lavaja/models/servico.dart';
import 'package:lavaja/view/buscaendereco.dart';

class ContratarServicoProvider with ChangeNotifier {
  final ContratarServicoService service;
  List<ContratarServico> contratarServico = [];
  String? token;
  String? teste;

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

  void patchContratarServico(
      int? id, String? statusServico, int? minutosAdicionais) async {
    await service.patchContratarServico(id, statusServico, minutosAdicionais);
    notifyListeners();
  }

  void deletarContratarServico(int? id) async {
    await service.deletarContratarServico(id);
    notifyListeners();
  }

  void createContratarServico(String? origem, String? placaCarro,
      int? servicoId, String? telefone) async {
    final contratarServLavacar = await service.createContratarServico(
        origem, placaCarro, servicoId, telefone);
    notifyListeners();
  }

  void createContratarServicoDonocarro(
      String? origem, int? servicoId, int? veiculo) async {
    final contratarServLavacar = await service.createContratarServicoDonoCarro(
        origem, servicoId, veiculo);
    notifyListeners();
  }

  // List<String> calculateTempoEspera() {
  //   List<String> tempos = [];

  //   for (var item in contratarServico) {
  //     if (item.statusServico == 'EM_LAVAGEM') {
  //       var tempoEspera =
  //           item.fimLavagem?.difference(DateTime.now()).inMinutes.toString() ??
  //               '';
  //       tempos.add(tempoEspera);
  //     } else {
  //       var tempoEspera = DateTime.parse(item.dataContratacaoServico!)
  //           .add(Duration(minutes: item.tempFila!))
  //           .difference(DateTime.now())
  //           .inMinutes
  //           .toString();
  //       tempos.add(tempoEspera);
  //     }
  //   }

  //   return tempos;
  // }

  Future<String?> getTokenFirebase(String id) async {
    token = await service.getTokenFirebase(id);
    return token;
  }

  Future<String?> getShedule() async {
    teste = await service.getShedule();
    notifyListeners();
    return teste;
  }
}
