import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/servico_service.dart';
import 'package:provider/provider.dart';

import '../data/contratarservico_service.dart';
import '../models/servico.dart';
import '../provider/contratarservico_provider.dart';
import '../provider/servico_provider.dart';
import '../routes/app_routes.dart';

class ContratarServLavacar extends StatefulWidget {
  @override
  State<ContratarServLavacar> createState() => _ContratarServLavacarState();
}

class _ContratarServLavacarState extends State<ContratarServLavacar> {
  final _form = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  TextEditingController _origemController =
      TextEditingController(text: 'LOCAL');
  Servico? _selectedOption;

  @override
  void initState() {
    super.initState();
    _origemController.text = 'LOCAL'; // Definir o valor 'LAVACAR' no controller
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ServicoProvider>(
      create: (context) => ServicoProvider(service: ServicoService()),
      child: Builder(
        builder: (context) {
          final data = Provider.of<ServicoProvider>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Incluir veículo na fila'),
              leading: IconButton(onPressed: () {
                  Modular.to.navigate(AppRoutes.CREATEFILA);
              }, icon: Icon(Icons.arrow_back)),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      enabled: false,
                      controller: _origemController, // Usar o controller para exibir o valor
                      decoration: InputDecoration(labelText: 'Origem'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Placa do carro'),
                      onChanged: (value) => _formData['placaCarro'] = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<Servico>(
                      items: data.meusServicos.map((Servico value) {
                        return DropdownMenuItem<Servico>(
                          value: value,
                          child: Text('${value.nome}'),
                        );
                      }).toList(),
                      onChanged: (Servico? value) {
                        _selectedOption = value;
                        _formData['servico'] = value?.id;
                      },
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Selecione o serviço',
                        border: null,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        
                        final isValid = _form.currentState?.validate();
                        if (isValid!) {
                          _form.currentState!.save();
                          _formData['origem'] = 'LOCAL'; // Definir o valor 'LAVACAR' para origem
                          Provider.of<ContratarServicoProvider>(context, listen: false).createContratarServico(
                            _formData['origem'] ?? '',
                            _formData['placaCarro'] ?? '',
                             _formData['servico'] ?? '',
                          );

                          Modular.to.navigate(AppRoutes.CREATEFILA);
                          _cadastroRealizado(context);

                        }
                      },
                      child: Text('Salvar'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void _cadastroRealizado(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Cadastro realizado com sucesso!'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    ),
  );
}
