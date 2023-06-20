import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/models/servico.dart';
import 'package:lavaja/provider/servico_provider.dart';
import 'package:provider/provider.dart';

import '../routes/app_routes.dart';

class ServicoForm extends StatefulWidget {
  final String? id;
  final bool isEditing;

  const ServicoForm({Key? key, required this.isEditing, this.id})
      : super(key: key);
  @override
  State<ServicoForm> createState() => _ServicoFormState();
}

class _ServicoFormState extends State<ServicoForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  Servico? servico;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ServicoProvider>(context, listen: false)
          .getServicoById(widget.id!)
          .then((e) {
        _formData['id'] = e?.id.toString() ?? '';
        _formData['nome'] = e?.nome ?? '';
        _formData['tempServico'] = e?.tempServico.toString() ?? '';
        _formData['valor'] = e?.valor.toString() ?? '';
        _formData['tamCarro'] = e?.tamCarro ?? '';
        _formData['ativo'] = e?.ativo?.toString() ?? 'false';
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.id == null ? 'Cadastro de serviço' : 'Editar serviço'),
        leading: IconButton(
            onPressed: () {
              Modular.to.navigate(AppRoutes.LISTASERVICO);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData['nome'],
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
                  initialValue: _formData['valor'],
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
                  initialValue: _formData['tamCarro'],
                  decoration: InputDecoration(labelText: 'Tamanho do carro'),
                  onChanged: (value) => _formData['tamCarro'] = value,
                ),
                TextFormField(
                  initialValue: _formData['tempServico'],
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
                      if (widget.id != null) {
                        Provider.of<ServicoProvider>(context, listen: false)
                            .updateServico(
                                _formData['id'] ?? '',
                                _formData['nome'] ?? '',
                                double.tryParse(_formData['valor'] ?? '') ??
                                    0.0,
                                _formData['tamCarro'] ?? '',
                                double.tryParse(
                                        _formData['tempServico'] ?? '') ??
                                    0.0,
                                _formData['ativo'] == 'true');
                        _edicaoRealizada(context);
                        Provider.of<ServicoProvider>(context, listen: false)
                            .loadServico()
                            .then((_) {
                          Modular.to.navigate(AppRoutes.LISTASERVICO);
                        });
                      } else {
                        Provider.of<ServicoProvider>(context, listen: false)
                            .createServico(
                                _formData['nome'] ?? '',
                                double.tryParse(_formData['valor'] ?? '') ??
                                    0.0,
                                _formData['tamCarro'] ?? '',
                                double.tryParse(
                                        _formData['tempServico'] ?? '') ??
                                    0.0,
                                _formData['ativo'] == 'true');
                        _cadastroRealizado(context);
                        Provider.of<ServicoProvider>(context, listen: false)
                            .loadServico()
                            .then((_) {
                          Modular.to.navigate(AppRoutes.LISTASERVICO);
                        });
                      }
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

void _edicaoRealizada(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Edição realizada com sucesso!'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    ),
  );
}
