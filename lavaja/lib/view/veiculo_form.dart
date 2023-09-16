import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/provider/veiculo_provider.dart';
import 'package:provider/provider.dart';

import '../routes/app_routes.dart';

class VeiculoForm extends StatefulWidget {
  final String? id;

  final bool isEditing;
  const VeiculoForm({Key? key, required this.isEditing, this.id})
      : super(key: key);

  @override
  State<VeiculoForm> createState() => _VeiculoFormState();
}

class _VeiculoFormState extends State<VeiculoForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print(widget.id);
    if (widget.id != null) {
      setState(() {
        isLoading = true;
      });
      Provider.of<VeiculoProvider>(context, listen: false)
          .getVeiculoById(widget.id!)
          .then((e) {
        _formData['id'] = e?.id.toString() ?? '';

        _formData['marca'] = e?.marca ?? '';

        _formData['modelo'] = e?.modelo ?? '';
        _formData['placa'] = e?.placa ?? '';
        _formData['cor'] = e?.cor ?? '';
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
        title: Text(widget.id == null ? 'CADASTRAR VEÍCULO' : 'EDITAR VEÍCULO'),
        leading: IconButton(
            onPressed: () {
              Modular.to.navigate(AppRoutes.LISTAVEICULOS);
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
                initialValue: _formData['marca'],
                decoration: InputDecoration(labelText: 'Marca'),
                onChanged: (value) => _formData['marca'] = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['modelo'],
                decoration: InputDecoration(labelText: 'Modelo'),
                onChanged: (value) => _formData['modelo'] = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['placa'],
                decoration: InputDecoration(labelText: 'Placa'),
                onChanged: (value) => _formData['placa'] = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['cor'],
                decoration: InputDecoration(labelText: 'Cor'),
                onChanged: (value) => _formData['cor'] = value,
                validator: (value) {},
              ),
              ElevatedButton(
                onPressed: () async {
                  final isValid = _form.currentState?.validate();
                  if (isValid!) {
                    _form.currentState!.save();
                    if (widget.id != null) {
                      try {
                        await Provider.of<VeiculoProvider>(context,
                                listen: false)
                            .update(
                                int.parse(_formData['id'] ?? ''),
                                _formData['marca'] ?? '',
                                _formData['modelo'] ?? '',
                                _formData['placa'] ?? '',
                                _formData['cor'] ?? '');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Veículo editado com sucesso!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Provider.of<VeiculoProvider>(context, listen: false)
                            .loadVeiculo()
                            .then((_) {
                          Modular.to.navigate(AppRoutes.LISTAVEICULOS);
                        });
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erro ao editar veículo'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {
                      try {
                        await Provider.of<VeiculoProvider>(context,
                                listen: false)
                            .createVeiculo(
                          _formData['marca'] ?? '',
                          _formData['modelo'] ?? '',
                          _formData['placa'] ?? '',
                          _formData['cor'] ?? '',
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Veículo criado com sucesso!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Provider.of<VeiculoProvider>(context, listen: false)
                            .loadVeiculo()
                            .then((_) {
                          Modular.to.navigate(AppRoutes.LISTAVEICULOS);
                        });
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erro ao criar veículo'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  }
                },
                child: Text('Salvar'),
              ),
              Visibility(
                visible: widget.id != null,
                child: ElevatedButton(
                  onPressed: () async {
                    if (widget.id != null) {
                      int? veiculoId = int.tryParse(widget.id!);
                      if (veiculoId != null) {
                        await Provider.of<VeiculoProvider>(context,
                                listen: false)
                            .deletar(veiculoId);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text('Excluir'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
