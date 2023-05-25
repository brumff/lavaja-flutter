import 'package:flutter/material.dart';
import 'package:lavaja/data/fila_service.dart';

class FilaProvider with ChangeNotifier {
  final FilaService service;

   FilaProvider({required this.service}) {
    //loadFila();
  }

  void createFila(String origem, String statusServico, DateTime dataServico, int donoCarro, int servico) async {
    final fila = await service.createFila(origem, statusServico, dataServico, donoCarro, servico);
   
  }
}