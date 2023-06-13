import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:lavaja/models/contratarservico.dart';
import 'package:provider/provider.dart';

import '../provider/contratarservico_provider.dart';

class Filalavacar extends StatefulWidget {
  @override
  State<Filalavacar> createState() => _FilalavacarState();
}

class _FilalavacarState extends State<Filalavacar> {
  List<int?> selectedItems = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {});
    });
  }

  void mostrarPopup(VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Deseja finalizar lavagem?'),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: Text('Confirmar'),
            ),
            TextButton(
              onPressed: () {
                Future.delayed(Duration(minutes: 1)).whenComplete(() {
                  mostrarPopup(
                    onPressed
                  );
                });
                Navigator.of(context).pop(); // Fechar o popup
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContratarServicoProvider>(
      create: (context) =>
          ContratarServicoProvider(service: ContratarServicoService()),
      child: Builder(
        builder: (context) {
          final data = Provider.of<ContratarServicoProvider>(context);

          return Scaffold(
            appBar: AppBar(title: Text('Fila')),
            body: Column(
              children: [
                Form(
                  child: Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                      Spacer(),
                      Column(
                        children: [
                          Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  iconTheme: IconThemeData(color: Colors.grey),
                                ),
                                child: Icon(Icons.circle),
                              ),
                              Text('Aguardando      ')
                            ],
                          ),
                          Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  iconTheme: IconThemeData(color: Colors.green),
                                ),
                                child: Icon(Icons.circle),
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
                  child: ListView.builder(
                    itemCount: data.contratarServico.length,
                    itemBuilder: (context, index) {
                      final item = data.contratarServico[index];
                      if (item.statusServico == 'FINALIZADO') {
                        // Ignorar itens com status "FINALIZADO"
                        return SizedBox.shrink();
                      }
                      bool isSelected = selectedItems.contains(item.id);
                      bool isEmLavagem = item.statusServico == 'EM_LAVAGEM';
                      var tempoEspera = DateTime.parse(item.dataServico!)
                          .add(Duration(minutes: item.tempFila!))
                          .difference(DateTime.now())
                          .inMinutes
                          .toString();
                      if (item.statusServico == 'EM_LAVAGEM') {
                        tempoEspera = item.fimLavagem
                                ?.difference(DateTime.now())
                                .inMinutes
                                .toString() ??
                            '';
                      }
                      return ListTile(
                        title: InkWell(
                          onTap: () async {
                            if (item.statusServico == 'AGUARDANDO') {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Confirmação'),
                                    content: Text('Deseja iniciar lavagem?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Enviar dados para o backend usando o provider
                                          data.patchContratarServico(
                                            item.id,
                                            item.statusServico = 'EM_LAVAGEM',
                                          );
                                          item.fimLavagem = DateTime.now().add(
                                              Duration(
                                                  minutes: item
                                                      .servico!.tempServico!
                                                      .toInt()));

                                          Navigator.of(context)
                                              .pop(); // Fechar o popup
                                        },
                                        child: Text('Confirmar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Fechar o popup
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text('Carro em lavagem'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Fechar o popup
                                        },
                                        child: Text('Voltar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            await Future.delayed(Duration(
                                minutes: item.servico!.tempServico!.toInt()));
                            mostrarPopup(
                              () {
                                // Enviar dados para o backend usando o provider
                                data.patchContratarServico(
                                  item.id,
                                  item.statusServico = 'FINALIZADO',
                                );

                                Navigator.of(context).pop(); // Fechar o popup
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.car_crash,
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
                                'Placa: ${item.placaCarro}, Status: ${item.statusServico}, Tempo ${tempoEspera}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10),
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
          );
        },
      ),
    );
  }
}
