import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/provider/veiculo_provider.dart';
import 'package:provider/provider.dart';

import '../provider/lavacar_provider.dart';

class ContratarServDonocarro extends StatefulWidget {
  @override
  State<ContratarServDonocarro> createState() => _ContratarServDonocarroState();
  final String? lavacarId;
  final double? tempoDeEspera;
  final String? servicoSelecionado;
  final double? valorTotal;

  ContratarServDonocarro({
    this.lavacarId,
    this.tempoDeEspera,
    this.servicoSelecionado,
    this.valorTotal,
  });
}

class _ContratarServDonocarroState extends State<ContratarServDonocarro> {
  String selectedVehicle = '';
  double? tempoDeEspera;
  String? servicoSelecionado;
  double? valorTotal;
  String? lavacarNome;
  String? lavacarRua;
  String? lavacarNumero;
  String? lavacarBairro;
  String? lavacarCidade;
  String? lavacarTelefone1;
  String? lavacarTelefone2;
  double? lavacarTempoFila;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final args = Modular.args;
    tempoDeEspera = args.data['tempoDeEspera'];
    servicoSelecionado = args.data['servicoSelecionado'];
    valorTotal = double.parse(args.data['valorTotal']);
    Provider.of<LavacarProvider>(context, listen: false)
        .LavacaId(widget.lavacarId!)
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

    final veiculoProvider =
        Provider.of<VeiculoProvider>(context, listen: false);
    veiculoProvider.loadVeiculo();

    print(veiculoProvider.veiculos);

    for (var veiculo in veiculoProvider.veiculos) {
      print('ID: ${veiculo.id}');
      print('Marca: ${veiculo.marca}');
      print('Modelo: ${veiculo.modelo}');
      print('Placa: ${veiculo.placa}');
      // Adicione mais campos aqui, se necessário
      print('---'); // Separador entre os veículos
    }
  }

  @override
  Widget build(BuildContext context) {
    final veiculoProvider = Provider.of<VeiculoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo do pedido'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.location_on_sharp,
                              ),
                              title: Text(
                                '${lavacarNome}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Endereço: ${lavacarRua}, ${lavacarNumero} - ${lavacarBairro}, ${lavacarCidade}',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.timer,
                              ),
                              title: Text(
                                'Tempo de espera',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${tempoDeEspera} Min.',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.local_car_wash_sharp,
                              ),
                              title: Text(
                                'Serviço',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text('${servicoSelecionado}'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.directions_car_filled_sharp,
                              ),
                              title: Text(
                                'Veículo',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: DropdownButton(
                                value: selectedVehicle.isNotEmpty
                                    ? selectedVehicle
                                    : veiculoProvider
                                                .veiculo?.placa?.isNotEmpty ==
                                            true
                                        ? veiculoProvider.veiculo!
                                            .placa // Use a string diretamente
                                        : null,
                                items: [
                                  DropdownMenuItem(
                                    value: veiculoProvider.veiculo?.placa,
                                    child: Text(
                                        veiculoProvider.veiculo?.placa ??
                                            'Selecione um veículo'),
                                  ),
                                ],
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedVehicle = newValue.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.paid,
                              ),
                              title: Text(
                                'Valor total',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text('R\$ ${valorTotal}'),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: Text('CONFIRMAR')),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
