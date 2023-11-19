import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../components/menu_lavacar_component.dart';
import '../provider/contratarservico_provider.dart';

class Filalavacar extends StatefulWidget {
  @override
  State<Filalavacar> createState() => _FilalavacarState();
}

class _FilalavacarState extends State<Filalavacar> {
  List<int?> selectedItems = [];
  bool serviceStarted = false;
  late Timer timer;
  int? diferencaEmMinutos;
  bool? mostrarPopupAberta = false;
  int contadorPopup = 0;
  Map<int, bool> popUpAbertaMap = {};

  @override
  void initState() {
    super.initState();
    Provider.of<ContratarServicoProvider>(context, listen: false)
        .loadContratarServico();
    timer = Timer.periodic(Duration(seconds: 15), (timer) {
      Provider.of<ContratarServicoProvider>(context, listen: false)
          .loadContratarServico();

      setState(() {});
    });
  }

  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext contextBuild) {
    return ChangeNotifierProvider<ContratarServicoProvider>(
      create: (contextProvider) =>
          ContratarServicoProvider(service: ContratarServicoService()),
      child: Builder(
        builder: (contextBuilder) {
          final data = Provider.of<ContratarServicoProvider>(context);
          final lavacarProvider = Provider.of<LavacarProvider>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('FILA'),
            ),
            body: Column(
              children: [
                Form(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Modular.to.navigate(AppRoutes.CONTRATARSERVLAVACAR);
                          },
                          icon: Icon(Icons.add)),
                      Spacer(),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.yellow,
                              ),
                              Text('Aguardando      ')
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                              ),
                              Text('Em andamento ')
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: data.contratarServico.isEmpty ||
                          data.contratarServico.every(
                              (item) => item.statusServico == 'FINALIZADO')
                      ? Center(
                          child: Column(
                            children: [
                              Text(
                                'Não há veículos na fila',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Image.asset(
                                'assets/images/fila.png',
                                height: 300,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: data.contratarServico.length,
                          itemBuilder: (context, index) {
                            final item = data.contratarServico[index];

                            print(item.id);

                            print(mostrarPopupAberta);
                            print(item.dataPrevisaoServico);

                            //calculo previsão data atual
                            DateTime agora = DateTime.now();
                            String? dataPrevisao = item.dataPrevisaoServico;
                            var dataPrevisaoData =
                                DateTime.tryParse(dataPrevisao ?? '');
                            Duration? diferencaPrevisao =
                                dataPrevisaoData?.difference(agora);
                            int? difEmMinutosPrev = diferencaPrevisao?.inMinutes ?? 0;

                            //calculo atraso data atual

                            String? dataAtraso = item.atrasado;
                            var dataAtrasoData =
                                DateTime.tryParse(dataAtraso ?? '');
                            Duration? diferencaAtraso =
                                dataAtrasoData?.difference(agora);
                            int? difEmMinutosAtraso =
                                diferencaAtraso?.inMinutes;
                            print('diferençaaa atrasasdo $difEmMinutosAtraso');

                            if (difEmMinutosAtraso == null) {
                              difEmMinutosAtraso = 100000;
                            }

                            if (item.statusServico == 'EM_LAVAGEM') {
                              if ((difEmMinutosPrev == 0 &&
                                      contadorPopup == 0) &&
                                  mostrarPopupAberta == false) {
                                {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    _mostrarPopup(
                                        context,
                                        data,
                                        index,
                                        item.placaCarro ?? '',
                                        item.id ?? 0,
                                        item.statusServico ?? '',
                                        item.minutosAdicionais ?? 0);
                                  });
                                }
                              } else if ((difEmMinutosAtraso == 0) &&
                                  mostrarPopupAberta == false) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  _mostrarPopup(
                                      context,
                                      data,
                                      index,
                                      item.placaCarro ?? '',
                                      item.id ?? 0,
                                      item.statusServico ?? '',
                                      item.minutosAdicionais ?? 0);
                                });
                              }
                            }

                            if (item.statusServico == 'FINALIZADO') {
                              return SizedBox.shrink();
                            }
                            bool isSelected = selectedItems.contains(item.id);
                            bool isEmLavagem =
                                item.statusServico == 'EM_LAVAGEM';

                            return ListTile(
                              title: InkWell(
                                onTap: () async {
                                  if (item.statusServico == 'AGUARDANDO') {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Confirmação'),
                                          content: Text(
                                              'Deseja iniciar lavagem? Carro: ${item.placaCarro}'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                data.patchContratarServico(
                                                    item.id,
                                                    item.statusServico =
                                                        'EM_LAVAGEM',
                                                    item.minutosAdicionais = 0);

                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Confirmar'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancelar'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else if (item.statusServico ==
                                      'EM_LAVAGEM') {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      _mostrarPopup(
                                          context,
                                          data,
                                          index,
                                          item.placaCarro ?? '',
                                          item.id ?? 0,
                                          item.statusServico ?? '',
                                          item.minutosAdicionais ?? 0);
                                    });
                                  }
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.local_car_wash_outlined,
                                          color: isEmLavagem
                                              ? Colors.green
                                              : (isSelected
                                                  ? Colors.green
                                                  : Colors.yellow),
                                          size: 70,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      
                                      children: [
                                        
                                        Text(
                                            'Placa: ${item.placaCarro} -  Status: ${item.statusServico?.replaceAll('_', ' ')}'),
                                        Text(
                                            'Tempo de Lavagem: ${difEmMinutosPrev < 0 ? 0 : difEmMinutosPrev} min.'),
                                        if (difEmMinutosAtraso != 100000)
                                          Text(
                                              'Tempo de Atraso: ${difEmMinutosAtraso} min.', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
            drawer: MenuLavacarComponent(),
          );
        },
      ),
    );
  }

  void _mostrarPopup(
      BuildContext context,
      ContratarServicoProvider data,
      int index,
      String placaCarro,
      int id,
      String statusServico,
      int minutosAdicionais) {
    TextEditingController atrasoController = TextEditingController();
    mostrarPopupAberta = true;
    contadorPopup += 1;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text('Deseja finalizar serviço? Carro: ${placaCarro}')),
              IconButton(
                icon: Icon(Icons.close, size: 15,), // Adicionando um ícone "X" para fechar
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  print('popup aberta: ${mostrarPopupAberta}');
                  data.patchContratarServico(
                    id,
                    statusServico = 'FINALIZADO',
                    minutosAdicionais = 0,
                  );
                  mostrarPopupAberta = false;
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  primary: Colors.white,
                ),
                child: Text('Finalizar serviço'),
              ),
              Divider(),
              SizedBox(height: 10),
              Text('Caso tenha atraso, informe abaixo em min:'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: atrasoController,
                      decoration: InputDecoration(labelText: 'Min.'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      minutosAdicionais =
                          int.tryParse(atrasoController.text) ?? 0;
                      data.patchContratarServico(
                        id,
                        statusServico = 'EM_LAVAGEM',
                        minutosAdicionais = minutosAdicionais,
                      );
                      contadorPopup += 1;
                      mostrarPopupAberta = false;
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      primary: Colors.white,
                    ),
                    child: Text('Informar atraso'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
