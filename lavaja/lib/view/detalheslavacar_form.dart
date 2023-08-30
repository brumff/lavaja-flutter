import 'package:flutter/material.dart';
import 'package:lavaja/data/detalhesservico_service.dart';
import 'package:lavaja/data/servico_service.dart';
import 'package:lavaja/models/servico.dart';
import 'package:lavaja/provider/detalhesservico_provider.dart';
import 'package:lavaja/provider/servico_provider.dart';
import 'package:provider/provider.dart';

import '../components/menu_lavacar_component.dart';

class DetalhesLavacarForm extends StatefulWidget {
  @override
  State<DetalhesLavacarForm> createState() => _DetalhesLavacarFormState();
}

class _DetalhesLavacarFormState extends State<DetalhesLavacarForm> {
  final DetalhesServicoService detalhesServicoService = DetalhesServicoService(); // Seu serviço

  List<Servico> detalhesServicos = []; // Lista para armazenar os detalhes de serviço

  @override
  void initState() {
    super.initState();
    loadDetalhesServicos(); // Carregar os detalhes de serviço ao iniciar o widget
  }

  Future<void> loadDetalhesServicos() async {
    // Chamar o serviço para carregar os detalhes de serviço
    detalhesServicos = await detalhesServicoService.getDetalhesServicos('3');

    setState(() {}); // Atualizar o estado do widget para exibir a lista
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nome do lavacar'),
      ),
      body: ListView.builder(
        itemCount: detalhesServicos.length,
        itemBuilder: (context, index) {
          final detalhe = detalhesServicos[index];
          return ListTile(
            title: Text(detalhe.nome ?? ''),
            // Outras propriedades do detalhe podem ser exibidas aqui
          );
        },
      ),
    );
  }
}