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

  @override
  void initState() {
    super.initState();
    Provider.of<ContratarServicoProvider>(context, listen: false)
        .loadContratarServico();
    timer = Timer.periodic(Duration(minutes: 1), (timer) {
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
                                color: Colors.grey,
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
                                DateTime.tryParse(dataPrevisao!);
                            Duration diferencaPrevisao =
                                dataPrevisaoData!.difference(agora);
                            int difEmMinutosPrev = diferencaPrevisao.inMinutes;
                            //calculo atraso data atual
                            print(difEmMinutosPrev);
                            String? dataAtraso = item.atrasado;
                            var dataAtrasoData =
                                DateTime.tryParse(dataAtraso ?? '');
                            Duration? diferencaAtraso =
                                dataAtrasoData?.difference(agora);
                            int? difEmMinutosAtraso =
                                diferencaAtraso?.inMinutes;
                            if (difEmMinutosAtraso == null) {
                              difEmMinutosAtraso = 5;
                            }
                            if (item.statusServico == 'EM_LAVAGEM') {
                              if ((difEmMinutosPrev == 0 &&
                                      contadorPopup == 0) ||
                                  difEmMinutosAtraso == 0 &&
                                      mostrarPopupAberta == false) {
                                if ((difEmMinutosPrev == 0 ||
                                        difEmMinutosAtraso == 0) &&
                                    mostrarPopupAberta == false) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    TextEditingController atrasoController =
                                        TextEditingController();
                                    mostrarPopupAberta = true;
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        final data = Provider.of<
                                            ContratarServicoProvider>(context);

                                        return AlertDialog(
                                          title: Text(
                                              'Deseja finalizar serviço? Carro:  $item.placaCarro'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  print(
                                                      'popup aberta: ${mostrarPopupAberta} ');
                                                  data.patchContratarServico(
                                                      item.id,
                                                      item.statusServico =
                                                          'FINALIZADO',
                                                      item.minutosAdicionais =
                                                          0);

                                                  Navigator.of(context).pop();
                                                },
                                                style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    primary: Colors.white),
                                                child:
                                                    Text('Finalizar serviço'),
                                              ),
                                              Divider(),
                                              SizedBox(height: 10),
                                              Text(
                                                  'Caso tenha atraso, informe abaixo em min:'),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller:
                                                          atrasoController,
                                                      decoration:
                                                          InputDecoration(
                                                              labelText:
                                                                  'Min.'),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      item.minutosAdicionais =
                                                          int.tryParse(
                                                                  atrasoController
                                                                      .text) ??
                                                              0;
                                                      data.patchContratarServico(
                                                          item.id,
                                                          item.statusServico =
                                                              'EM_LAVAGEM',
                                                          item.minutosAdicionais =
                                                              item.minutosAdicionais);

                                                      contadorPopup += 1;
                                                      mostrarPopupAberta =
                                                          false;
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    style: TextButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.blue,
                                                        primary: Colors.white),
                                                    child:
                                                        Text('Informar atraso'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  });
                                }
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
                                  } else {}
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
                                                  : Colors.grey),
                                          size: 70,
                                        ),
                                      ],
                                    ),
                                    Text(
                                        'Placa: ${item.placaCarro}, Status: ${item.statusServico} - Tempo: ${difEmMinutosPrev}  - Atrasado: '),
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

//   Future<void> mostrarPopup(VoidCallback onPressed, String placaCarro, int id,
//       String statusServico, int minutosAdicionais) async {
//     TextEditingController atrasoController = TextEditingController();
//     if (!mostrarPopupAberta!) {
//       showDialog(
//         context: context,
//         builder: (context) {
//           final data = Provider.of<ContratarServicoProvider>(context);

//           return AlertDialog(
//             title: Text('Deseja finalizar serviço? Carro:  $placaCarro'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     data.patchContratarServico(id, statusServico = 'FINALIZADO',
//                         minutosAdicionais = 0);

//                     Navigator.of(context).pop();
//                   },
//                   style: TextButton.styleFrom(
//                       backgroundColor: Colors.blue, primary: Colors.white),
//                   child: Text('Finalizar serviço'),
//                 ),
//                 Divider(),
//                 SizedBox(height: 10),
//                 Text('Caso tenha atraso, informe abaixo em min:'),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: atrasoController,
//                         decoration: InputDecoration(labelText: 'Min.'),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         minutosAdicionais =
//                             int.tryParse(atrasoController.text) ?? 0;
//                         data.patchContratarServico(
//                             id,
//                             statusServico = 'EM_LAVAGEM',
//                             minutosAdicionais = minutosAdicionais);

//                         Navigator.of(context).pop();
//                       },
//                       style: TextButton.styleFrom(
//                           backgroundColor: Colors.blue, primary: Colors.white),
//                       child: Text('Informar atraso'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     }
//   }
}
