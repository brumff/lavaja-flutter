import 'package:flutter/material.dart';
import 'package:lavaja/data/detalhesservico_service.dart';
import 'package:lavaja/data/servico_service.dart';
import 'package:lavaja/models/servico.dart';
import 'package:lavaja/provider/detalhesservico_provider.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:lavaja/provider/servico_provider.dart';
import 'package:provider/provider.dart';

import '../components/menu_lavacar_component.dart';
import '../models/lavacar.dart';

class DetalhesLavacarForm extends StatefulWidget {
  final String? id;

  DetalhesLavacarForm({required this.id});

  @override
  State<DetalhesLavacarForm> createState() => _DetalhesLavacarFormState();
}

class _DetalhesLavacarFormState extends State<DetalhesLavacarForm> {
  List<Servico> detalhesServicos = [];
  Lavacar? lavacar;
  bool isLoading = false;
  String? lavacarNome;
  String? lavacarRua;
  String? lavacarNumero;
  String? lavacarBairro;
  String? lavacarCidade;
  String? lavacarTelefone1;
  String? lavacarTelefone2;
  double? lavacarTempoFila;

  @override
  void initState() {
    super.initState();
    Provider.of<LavacarProvider>(context, listen: false)
        .LavacaId(widget.id!)
        .then((e) {
      lavacarNome = e?.nome ?? '';
      lavacarRua = e?.rua ?? '';
      lavacarNumero = e?.numero ?? '';
      lavacarBairro = e?.bairro ?? '';
      lavacarCidade = e?.cidade ?? '';
      lavacarTelefone1 = e?.telefone1 ?? '';
      lavacarTelefone2 = e?.telefone2 ?? '';
      lavacarTempoFila = e?.tempoFila ?? 0.0;
      setState(() {
        isLoading = false;
      });
    });
    Provider.of<DetalhesServicoProvider>(context, listen: false)
        .getDetalhesServico(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${lavacarNome}'.toUpperCase()),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${lavacarNome}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        'Tempo fila: ${lavacarTempoFila?.toStringAsFixed(0)} Min.',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 2, 16, 16),
                  child: Text(
                      'Endereço: ${lavacarRua}, ${lavacarNumero} - ${lavacarBairro}, ${lavacarCidade}'),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 2, 2, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Serviços:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Consumer<DetalhesServicoProvider>(builder: (_, data, __) {
            return ListView.builder(
                itemCount: data.detalhesServico.length,
                itemBuilder: (context, index) {
                  final item = data.detalhesServico[index];
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            item.nome ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'R\$ ${item.valor.toString() ?? ''}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Contratar Serviço',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(),
                        )
                      ],
                    ),
                  );
                });
          }))
        ],
      ),
    );
  }
}
