import 'package:flutter/material.dart';
import 'package:lavaja/data/servico_service.dart';
import 'package:lavaja/models/servico.dart';

class ServicoProvider with ChangeNotifier {
  final ServicoService service;
  List<Servico> _servico = [];
  List<Servico> meusServicos = [];

  ServicoProvider({required this.service}) {
    loadServico();
  }

  /*ServicoProvider({required this.service}) {
    loadServicos();
  }*/

    Future<void> loadServico() async {
    meusServicos = await service.getListarServicosLavacar();
    notifyListeners();
  }


 /* Future<void> loadServico() async {
    _servico = await service.getServico();
    notifyListeners();
  }*/

  void createServico(String nome, double valor, String tamCarro,
      double tempServico, bool ativo) async {
    final servico =
        await service.createServico(nome, valor, tamCarro, tempServico, ativo);
    await loadServico();
    notifyListeners();
  }
}
