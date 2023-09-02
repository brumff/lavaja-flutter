import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/data/detalhesservico_service.dart';
import 'package:lavaja/data/servico_service.dart';
import 'package:lavaja/data/veiculo_service.dart';
import 'package:lavaja/models/contratarservico.dart';
import 'package:lavaja/provider/contratarservico_provider.dart';
import 'package:lavaja/provider/detalhesservico_provider.dart';
import 'package:lavaja/provider/donocarro_provider.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:lavaja/provider/servico_provider.dart';
import 'package:lavaja/provider/veiculo_provider.dart';
import 'package:lavaja/view/filavacar_form.dart';
import 'package:provider/provider.dart';

import 'controller/teste_controller.dart';
import 'data/donocarro_service.dart';
import 'data/lavacar_service.dart';

class AppWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LavacarProvider>(
          create: (ctx) => LavacarProvider(service: LavacarService()),
        ),
        ChangeNotifierProvider<DonoCarroProvider>(
          create: (ctx) => DonoCarroProvider(service: DonoCarroService()),
        ),
         ChangeNotifierProvider<ServicoProvider>(
          create: (ctx) => ServicoProvider(service: ServicoService()),
        ),
        ChangeNotifierProvider<ContratarServicoProvider>(
          create: (ctx) => ContratarServicoProvider(service: ContratarServicoService()),
        ),
        ChangeNotifierProvider<DetalhesServicoProvider>(
          create: (ctx) => DetalhesServicoProvider(service: DetalhesServicoService()),
        ),
         ChangeNotifierProvider<LocalizacaoController>(
          create: (ctx) => LocalizacaoController(),
        ),
        ChangeNotifierProvider<VeiculoProvider>(
          create: (ctx) => VeiculoProvider(service: VeiculoService()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Lavaja',
        theme: ThemeData(primarySwatch: Colors.blue),
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,

      ),
    ); //added by extension
  }
}
