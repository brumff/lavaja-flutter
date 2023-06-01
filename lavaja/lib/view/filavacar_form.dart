import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/models/contratarservico.dart';
import 'package:provider/provider.dart';

import '../provider/contratarservico_provider.dart';
import '../provider/home_donocarro_provider.dart';

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
  }

  void startCountdown(int initialValue, int index) {
    countdownValues[index] = initialValue;

    countdownTimers[index] = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countdownValues[index]--;
        if (countdownValues[index] < -10) {
          timer.cancel();
        }
      });
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
                        if (countdownTimers.length <= index) {
                          countdownValues.add(item.tempFila ?? 0);
                          countdownTimers.add(null);
                        }

                        if (countdownTimers[index] == null &&
                            item.tempFila != null) {
                          startCountdown(item.tempFila!, index);
                        }
                        return ListTile(
                          title: GestureDetector(
                              onTap: () {
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
                                          item.statusServico = 'AGUARDANDO');
                                } else {
                                  // Se não estiver selecionado, altera para "EM_LAVAGEM"
                                  Provider.of<ContratarServicoProvider>(context,
                                          listen: false)
                                      .patchContratarServico(item.id,
                                          item.statusServico = 'EM_LAVAGEM');
                                }
                                print(item.id);
                                print(item.statusServico);
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

                                          print(item.id);
                                          print(item.statusServico);
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
                                    'ID: ${item.id}, Status: ${item.statusServico}, Tempo ${countdownValues[index]}',
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
