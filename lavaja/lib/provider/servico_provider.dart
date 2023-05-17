import 'package:flutter/material.dart';
import 'package:lavaja/data/servico_service.dart';
import 'package:lavaja/models/servico.dart';

class ServicoProvider with ChangeNotifier {
  final ServicoService service;
  List<Servico> _servicos = [];
  List<Servico> meusServicos = [];
  Servico? servico;

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

  
  Future<Servico?> getServicoById(String id) async {
    servico = await service.getServicoById(id);
    return servico;
  }

  Future<void> getServico() async {
    _servicos = await service.getServico();
    notifyListeners();
  }

  void createServico(String nome, double valor, String tamCarro,
      double tempServico, bool ativo) async {
    final servico =
        await service.createServico(nome, valor, tamCarro, tempServico, ativo);
    await loadServico();
    notifyListeners();
  }

  void updateServico(String nome, double valor, String tamCarro,
      double tempServico, bool ativo) async {
    final servico =
        await service.createServico(nome, valor, tamCarro, tempServico, ativo);
    await loadServico();
    notifyListeners();
  }
}
