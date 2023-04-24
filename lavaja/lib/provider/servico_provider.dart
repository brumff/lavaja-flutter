import 'package:flutter/material.dart';
import 'package:lavaja/data/servico_service.dart';
import 'package:lavaja/models/servico.dart';

class ServicoProvider with ChangeNotifier {
  final ServicoService service;

  ServicoProvider({required this.service}){
    loadServico();
  }

   List<Servico> _servico = [];

   Future<void> loadServico() async {
    _servico = await service.getServico();
    notifyListeners();
  }

  void createServico(
      String nome,
      double valor,
      String tamCarro,
      double tempServico,
      bool ativo
      ) async {
    final servico = await service.createServico(nome, valor, tamCarro, tempServico, ativo);
    await loadServico();
    notifyListeners();
  }


}