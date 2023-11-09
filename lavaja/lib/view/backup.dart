import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/menu_lavacar_component.dart';
import '../data/contratarservico_service.dart';
import '../provider/contratarservicodonocarro_provider.dart';
import 'historicoservico_donocarro.dart';

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
          final itemProvider = Provider.of<ContratarServicoDonocarroProvider>(context);
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
                Color statusColor;
                IconData statusIcon;

                if (item.statusServico == 'Aguardando') {
                  statusColor = Colors.yellow;
                  statusIcon = Icons.access_time;
                } else {
                  statusColor = Colors.green; 
                  statusIcon = Icons.check_circle; 
                }

                final statusText = 'Status: ${item.statusServico}';
                final textSplit = statusText.split(': ');
                final labelText = textSplit[0] + ': ';
                final highlightedText = textSplit[1];

                return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Row(
                        children: [
                          Icon(
                            statusIcon,
                            color: statusColor,
                          ),
                          SizedBox(width: 10.0),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: labelText,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: highlightedText,
                                  style: TextStyle(
                                    color: Colors.black, // Cor preta
                                    backgroundColor: Colors.yellow, // Cor de marca-texto
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  body: ListTile(
                    // title: Text(
                    //   'Serviço: ${item.servicoId?.nome} - Valor: ${item.servicoId?.valor}',
                    // ),
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
