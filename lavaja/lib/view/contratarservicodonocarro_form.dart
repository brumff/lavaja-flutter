import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lavaja/data/veiculo_service.dart';
import 'package:lavaja/provider/veiculo_provider.dart';
import 'package:provider/provider.dart';
import 'package:lavaja/models/veiculo.dart';

import '../data/prefs_service.dart';
import '../provider/contratarservico_provider.dart';
import '../provider/lavacar_provider.dart';
import '../routes/app_routes.dart';

class ContratarServDonocarro extends StatefulWidget {
  @override
  State<ContratarServDonocarro> createState() => _ContratarServDonocarroState();
  final String? lavacarId;
  final double? tempoDeEspera;
  final String? servicoSelecionado;
  final double? valorTotal;
  final int? idServico;

  ContratarServDonocarro({
    this.lavacarId,
    this.tempoDeEspera,
    this.servicoSelecionado,
    this.idServico,
    this.valorTotal,
  });
}

class _ContratarServDonocarroState extends State<ContratarServDonocarro> {
  String selectedVehicle = '';
  double? tempoDeEspera;
  String? servicoSelecionado;
  int? idServico;

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
  Veiculo? _selectedOption;
  final _form = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();
    _getToken();
    final args = Modular.args;
    tempoDeEspera = args.data['tempoDeEspera'];
    servicoSelecionado = args.data['servicoSelecionado'];
    idServico = args.data['idServico'];
    //print(idServico);
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
  }

  _getToken() async {
    final token = await PrefsService.getToken();
    if (token != null) {
      final parts = token.split('Bearer ');
      if (parts.length == 2) {
        final encodedToken = parts[1];
        final decodedToken = JwtDecoder.decode(encodedToken);
        final userId = decodedToken['userId'];

        if (userId != null) {
          print('ID do usuário: $userId');
        } else {
          print('ID do usuário não encontrado no token.');
        }
      } else {
        print('Token inválido.');
      }
    } else {
      print('Token não encontrado.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final veiculoProvider = Provider.of<VeiculoProvider>(context);

    return ChangeNotifierProvider<VeiculoProvider>(
        create: (context) => VeiculoProvider(service: VeiculoService()),
        child: Builder(
          builder: (context) {
            final data = Provider.of<VeiculoProvider>(context);
            return Scaffold(
              appBar: AppBar(
                title: Text('RESUMO PEDIDO'),
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
                                        subtitle:
                                            DropdownButtonFormField<Veiculo>(
                                          items: data.veiculos
                                              .map((Veiculo value) {
                                            return DropdownMenuItem<Veiculo>(
                                              value: value,
                                              child: Text('${value.placa}'),
                                            );
                                          }).toList(),
                                          onChanged: (Veiculo? value) {
                                            _selectedOption = value;
                                            _formData['veiculo'] = value?.id;
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            hintText: 'Selecione o veículo',
                                            border: null,
                                          ),
                                        )),
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
                                    onPressed: () {
                                      _formData['origem'] = 'APP';
                                      _formData['idServico'] = idServico;
                                      Provider.of<ContratarServicoProvider>(
                                              context,
                                              listen: false)
                                          .createContratarServicoDonocarro(
                                              _formData['origem'] ?? '',
                                              _formData['idServico'] ?? '',
                                              _formData['veiculo'] ?? '');

                                      Modular.to.navigate(AppRoutes.SUCESSOCONTRATARSERV);
                                      _cadastroRealizado(context);
                                    },
                                    child: Text('CONFIRMAR')),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

void _cadastroRealizado(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Serviço contratado com sucesso'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    ),
  );
}
