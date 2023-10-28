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
//atualiza o tempo a cada 1 minuto
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {});
    });
  }

  //abre a pop para finalizar o serviço após o tempo ser zerado
  void mostrarPopup(VoidCallback onPressed, String placaCarro) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmação'),
          content: Text('Deseja finalizar lavagem? Carro: $placaCarro'),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: Text('Confirmar'),
            ),
            TextButton(
              onPressed: () {
                Future.delayed(Duration(minutes: 1)).whenComplete(() {
                  mostrarPopup(onPressed, placaCarro);
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
                  child: data.contratarServico.isEmpty ||
                          data.contratarServico.every(
                              (item) => item.statusServico == 'FINALIZADO')
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
                                height: 400,
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: data.contratarServico.length,
                          itemBuilder: (context, index) {
                            final item = data.contratarServico[index];

                            return ListTile(title: Text('${item.placaCarro} - ${item.tempFila}') );
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
}
