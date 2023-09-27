import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lavaja/components/menu_donocarro_component.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/models/contratarservico.dart';
import 'package:lavaja/provider/contratarservico_provider.dart';
import 'package:provider/provider.dart';

import '../components/menu_lavacar_component.dart';
import '../provider/contratarservicodonocarro_provider.dart';

class HistoricoServicoDonoCarro extends StatefulWidget {
  @override
  State<HistoricoServicoDonoCarro> createState() =>
      _HistoricoServicoDonoCarroState();
}

class _HistoricoServicoDonoCarroState extends State<HistoricoServicoDonoCarro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de serviços'),
      ),
      body: ChangeNotifierProvider<ContratarServicoDonocarroProvider>(
        create: (context) => ContratarServicoDonocarroProvider(
          service: ContratarServicoService(),
        ),
        builder: (context, _) {
          final itemProvider =
              Provider.of<ContratarServicoDonocarroProvider>(context);
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
                IconData statusIcon;

                if (item.statusServico == 'AGUARDANDO') {
                  statusIcon = Icons.access_time;
                } else {
                  statusIcon = Icons.check_circle;
                }
                return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Row(
                        children: [
                          Icon(statusIcon),
                          SizedBox(width: 10.0),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Carro: ${item.placaCarro} - Status: ',
                                ),
                                TextSpan(
                                    text: item.statusServico,
                                    style: TextStyle(
                                    
                                      backgroundColor:
                                          getStatusColor(item.statusServico ?? ''),
                                    )),
                              ],
                              style: DefaultTextStyle.of(context).style,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  body: ListTile(
                    title: Text(
                        'Serviço: ${item.servico?.nome} - Valor: ${item.servico?.valor}'),
                  ),
                  isExpanded: item.isExpanded ?? false,
                );
              }).toList(),
            ),
          );
        },
      ),
      drawer: MenuDonoCarroComponent(),
    );
  }
}

Color getStatusColor(String status) {
  switch (status) {
    case 'AGUARDANDO':
      return Colors.yellow;
    case 'CONCLUPIDO':
      return Colors.green;
    case 'CANCELADO':
      return Colors.red;
    // Adicione mais casos conforme necessário para outros status
    default:
      return Colors.black; // Cor padrão se o status não for reconhecido
  }
}
