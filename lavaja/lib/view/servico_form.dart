import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/models/servico.dart';
import 'package:lavaja/provider/servico_provider.dart';
import 'package:provider/provider.dart';

import '../routes/app_routes.dart';

class ServicoForm extends StatefulWidget {
  @override
  State<ServicoForm> createState() => _ServicoFormState();
}

class _ServicoFormState extends State<ServicoForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  Servico? servico;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de serviço'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  onChanged: (value) => _formData['nome'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Valor'),
                  onChanged: (value) => _formData['valor'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Tamanho do carro'),
                  onChanged: (value) => _formData['tamCarro'] = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Tempo serviço'),
                  onChanged: (value) => _formData['tempServico'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                CheckboxListTile(
                  title: Text('Ativo'),
                  value: _formData['ativo'] == 'true',
                  onChanged: (bool? value) {
                    setState(() {
                      _formData['ativo'] = value.toString();
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    final isValid = _form.currentState?.validate();
                    if (isValid!) {
                      _form.currentState!.save();
                      Provider.of<ServicoProvider>(context, listen: false)
                          .createServico(
                              _formData['nome'] ?? '',
                              double.tryParse(_formData['valor'] ?? '') ?? 0.0,
                              _formData['tamCarro'] ?? '',
                              double.tryParse(_formData['tempServico'] ?? '') ??
                                  0.0,
                              _formData['ativo'] == 'true');
                      Modular.to.navigate(AppRoutes.LISTASERVICO);
                    }
                  },
                  child: Text('Salvar'),
                ),
              ],
            )),
      ),
    );
  }
}

void _cadastroRealizado(BuildContext context) {
  // Aqui você pode salvar o cadastro e exibir o snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Serviço cadastrada com sucesso!'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green, // Definindo a cor de fundo do SnackBar
      //contentTextStyle: TextStyle(color: Colors.white),
    ),
  );
}
