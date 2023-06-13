import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/models/contratarservico.dart';
import 'package:provider/provider.dart';

import '../provider/contratarservico_provider.dart';
import '../provider/home_donocarro_provider.dart';
import '../routes/app_routes.dart';

class Filalavacar extends StatefulWidget {
  @override
  State<Filalavacar> createState() => _FilalavacarState();
}

class _FilalavacarState extends State<Filalavacar> {
  List<int?> selectedItems = [];
  List<int> countdownValues = [];
  List<Timer?> countdownTimers = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fila')),
      body: ChangeNotifierProvider<ContratarServicoProvider>(
        create: (context) =>
            ContratarServicoProvider(service: ContratarServicoService()),
        child: Consumer<ContratarServicoProvider>(
          builder: (_, data, __) => Column(
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
                                iconTheme: IconThemeData(color: Colors.grey)),
                            child: Icon(Icons.circle),
                          ),
                          Text('Aguardando      ')
                        ],
                      ),
                      Row(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                                iconTheme: IconThemeData(color: Colors.green)),
                            child: Icon(Icons.circle),
                          ),
                          Text('Em andamento ')
                        ],
                      )
                    ],
                  )
                ],
              )),
              Expanded(
                  child: ListView.builder(
                      itemCount: data.contratarServico.length,
                      itemBuilder: (context, index) {
                        final item = data.contratarServico[index];
                        bool isSelected = selectedItems.contains(item.id);
                        bool isEmLavagem = item.statusServico == 'EM_LAVAGEM';
                        var tempoEspera = DateTime.parse(item.dataServico!)
                            .add(Duration(minutes: item.tempFila!))
                            .difference(DateTime.now())
                            .inMinutes
                            .toString();
                        if (item.statusServico == 'EM_LAVAGEM') {
                          tempoEspera = '';
                        }
                        return ListTile(
                          title: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  if (isSelected) {
                                    selectedItems.remove(item.id);
                                  } else {
                                    selectedItems.add(item.id);
                                  }
                                });
                                if (isSelected) {
                                  // Se já estiver selecionado, altera para "AGUARDANDO"
                                  Provider.of<ContratarServicoProvider>(context,
                                          listen: false)
                                      .patchContratarServico(item.id,
                                          item.statusServico = 'EM_LAVAGEM');
                                }
                                await Future.delayed(Duration(
                                    minutes:
                                        item.servico!.tempServico!.toInt()));
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          'Deseja finalizar o serviço? ${item.placaCarro}'),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Provider.of<ContratarServicoProvider>(
                                                      context,
                                                      listen: false)
                                                  .patchContratarServico(
                                                      item.id,
                                                      item.statusServico =
                                                          'FINALIZADO');
                                              Modular.to.navigate(
                                                  AppRoutes.LISTASERVICO);
                                            },
                                            child: Text('Confirmar')),
                                      ],
                                    );
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
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedItems.remove(item.id);
                                          });
                                          // Altera o status para "AGUARDANDO"
                                          Provider.of<ContratarServicoProvider>(
                                                  context,
                                                  listen: false)
                                              .patchContratarServico(
                                                  item.id,
                                                  item.statusServico =
                                                      'AGUARDANDO');
                                        },
                                        child: Icon(
                                          Icons.keyboard_return,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            data.contratarServico.remove(item);
                                          });
                                          Provider.of<ContratarServicoProvider>(
                                                  context,
                                                  listen: false)
                                              .deletarContratarServico(item.id);
                                        },
                                        child: Icon(Icons.delete,
                                            color: Colors.red),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Placa: ${item.placaCarro}, Status: ${item.statusServico}, Tempo ${tempoEspera}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              )),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
