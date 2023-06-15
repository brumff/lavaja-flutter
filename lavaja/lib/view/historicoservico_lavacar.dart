import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/provider/contratarservico_provider.dart';
import 'package:provider/provider.dart';

import '../provider/servico_provider.dart';
import '../routes/app_routes.dart';

class HistoricoServicoLavacar extends StatelessWidget {
  static const appTitle = 'Histórico de serviços';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Modular.to.navigate(AppRoutes.HOMELAVACAR);
            }),
      ),
      body: ChangeNotifierProvider<ContratarServicoProvider>(
        create: (context) =>
            ContratarServicoProvider(service: ContratarServicoService()),
        child: Consumer<ContratarServicoProvider>(
          builder: (_, data, __) => ListView.builder(
            itemCount: data.contratarServico.length,
            itemBuilder: (context, index) {
              final item = data.contratarServico[index];
              return ExpansionPanelList(
                elevation: 2,
                expandedHeaderPadding: EdgeInsets.all(8),
                expansionCallback: (int panelIndex, bool isExpanded) {
                  // Implement your expansion logic here
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(
                          'Carro: ${item.placaCarro.toString()} - Data: ${item.statusServico}',
                        ),
                      );
                    },
                    body: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Data do serviço: ${item.dataServico}')
                        ],
                      ),
                    ),
                    isExpanded: false, // Set initial expansion state
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
