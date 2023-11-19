import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lavaja/components/menu_donocarro_component.dart';
import 'package:lavaja/components/menu_lavacar_component.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/models/contratarservico.dart';
import 'package:lavaja/provider/contratarservico_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HistoricoServicoLavacar extends StatefulWidget {
  @override
  State<HistoricoServicoLavacar> createState() =>
      _HistoricoServicoLavacarState();
}

class _HistoricoServicoLavacarState extends State<HistoricoServicoLavacar> {
  final TextStyle textStyle = TextStyle(
    fontFamily: 'San Francisco',
    fontSize: 16.0,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HISTÓRICO DE SERVIÇO'),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Não há itens no histórico.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Image.asset(
                    'assets/images/historico.png',
                    height: 400,
                  )
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: ExpansionPanelList(
              dividerColor: Colors.grey,
              elevation: 2,
              expandedHeaderPadding: EdgeInsets.only(bottom: 0.0),
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  itemList[index].isExpanded = isExpanded ? true : false;
                });
              },
              children: itemList.map((item) {
                final itemIndex = itemList.indexOf(item);
                IconData statusIcon;
                if (item.statusServico == 'AGUARDANDO') {
                  statusIcon = Icons.access_time;
                } else if (item.statusServico == 'FINALIZADO') {
                  statusIcon = Icons.check_circle;
                } else if (item.statusServico == 'EM_LAVAGEM') {
                  statusIcon = Icons.bubble_chart_outlined;
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
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Carro: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: item.veiculoId?.placa ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' - Status: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: item.statusServico,
                                    style: TextStyle(
                                      backgroundColor: getStatusColor(
                                          item.statusServico ?? ''),
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  body: ListTile(
                    title: Row(
                      children: [
                        SizedBox(width: 30.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Serviço: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${item.servicoId?.nome} -',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Valor: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'R\$ ${item.servicoId?.valor}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Data: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${formatarData(item.dataContratacaoServico?.toString() ?? '0')} - ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Cliente:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${item.placaCarro}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
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

Color? getStatusColor(String status) {
  switch (status) {
    case 'AGUARDANDO':
      return Colors.yellow[200];
    case 'FINALIZADO':
      return Colors.green[200];
    case 'CANCELADO':
      return Colors.red[200];
    case 'EM_LAVAGEM':
      return Colors.blue[200];
    default:
      return Colors.black12;
  }
}

String formatarData(String dataString) {
  final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
  final outputFormat = DateFormat('dd/MM/yyyy');
  final date = inputFormat.parse(dataString);
  return outputFormat.format(date);
}
