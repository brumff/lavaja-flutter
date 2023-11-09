import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/data/firebase_api.dart';
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

  @override
  void initState() {
    Provider.of<ContratarServicoProvider>(context, listen: false).loadContratarServico;
 
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
                        icon: Icon(Icons.add),
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                              ),
                              Text('Aguardando      '),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.grey,
                              ),
                              Text('Em andamento '),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Consumer<ContratarServicoProvider>(
                  builder: (context, data, child) {
                    return Expanded(
                      child: data.contratarServico.isEmpty ||
                              data.contratarServico.every(
                                (item) => item.statusServico == 'FINALIZADO',
                              )
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Não há carros na fila de espera neste momento.',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Image.asset(
                                    'assets/images/fila.png',
                                    height: 50,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: data.contratarServico.length,
                              itemBuilder: (context, index) {
                                final item = data.contratarServico[index];

                                return ListTile(
                                  title: InkWell(
                                    onTap:  () async {
                                      mostrarPopupIniciar(
                                        item.id,
                                        item.statusServico,
                                        item.placaCarro ?? '',
                                        item.minutosAdicionais,
                                      );
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
                                              size: 70,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Placa: ${item.placaCarro} - Status: ${item.statusServico}',
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    );
                  },
                ),
              ],
            ),
            drawer: MenuLavacarComponent(),
          );
        }
      ),
    );
  }

  void mostrarPopupIniciar(int? id, String? statusServico, String? placaCarro,
      int? minutosAdicionais) {
    showDialog(
      context: context,
      builder: (context) {
        final data = Provider.of<ContratarServicoProvider>(context);
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Deseja iniciar lavagem? Carro: $placaCarro'),
          actions: [
            TextButton(
              onPressed: () {
                data.patchContratarServico(id, 'EM_LAVAGEM', 0);
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
  }
}
