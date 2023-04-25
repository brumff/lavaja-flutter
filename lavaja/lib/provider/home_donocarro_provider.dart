import 'package:flutter/material.dart';
import 'package:lavaja/data/servico_service.dart';

import '../models/servico.dart';

class HomeDonoCarroProvider with ChangeNotifier {
  final ServicoService service;
  List<Servico> servicos = [];

  HomeDonoCarroProvider({required this.service}) {
    loadServico();
  }

  Future<void> loadServico() async {
    servicos = await service.getServicosAtivos();
    notifyListeners();
  }

  
}
