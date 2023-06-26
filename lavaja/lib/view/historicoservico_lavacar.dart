import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/models/contratarservico.dart';
import 'package:lavaja/provider/contratarservico_provider.dart';
import 'package:provider/provider.dart';

import '../components/menu_lavacar_component.dart';

class HistoricoServicoLavacar extends StatefulWidget {
  @override
  State<HistoricoServicoLavacar> createState() =>
      _HistoricoServicoLavacarState();
}

class _HistoricoServicoLavacarState extends State<HistoricoServicoLavacar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de serviços'),
      ),
      body: ChangeNotifierProvider<ContratarServicoProvider>(
        create: (context) => ContratarServicoProvider(
          service: ContratarServicoService(),
        ),
        builder: (context, _) {
          final itemProvider = Provider.of<ContratarServicoProvider>(context);
          final itemList = itemProvider.contratarServico;
          if (itemList.isEmpty) {
            return Center(
              child: Text('Nenhum histórico encontrado.'),
            );
          }
          return SingleChildScrollView(
            child: ExpansionPanelList(
              elevation: 1,
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  itemList[index].isExpanded = isExpanded ? false : true;
                });
              },
              children: itemList.map((item) {
                final itemIndex = itemList.indexOf(item);
                return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text(
                          'Carro: ${item.placaCarro} - Status: ${item.statusServico}'),
                    );
                  },
                  body: ListTile(
                    title: Text('Serviço: ${item.servico?.nome}'),
                  ),
                  isExpanded: item.isExpanded ?? false,
                );
              }).toList(),
            ),
          );
        },
      ),
      drawer: MenuLavacarComponent(),
    );
  }
}
