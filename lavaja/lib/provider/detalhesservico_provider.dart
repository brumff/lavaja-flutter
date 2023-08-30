import 'package:flutter/material.dart';

import '../data/detalhesservico_service.dart';
import '../models/servico.dart';

class DetalhesServicoProvider with ChangeNotifier {
  final DetalhesServicoService service;
  List<Servico> detalhesServico = [];
  Servico? servico;
  
  DetalhesServicoProvider({required this.service}) {
    loadDetalheServico();
  }

    Future<void> loadDetalheServico() async {
   
    notifyListeners();
  }

Future<List<Servico>> getDetalhesServico(String id) async {
  detalhesServico = await service.getDetalhesServicos(id);
  return detalhesServico;
}
}