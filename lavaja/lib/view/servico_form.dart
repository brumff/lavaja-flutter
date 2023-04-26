import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lavaja/models/servico.dart';
import 'package:lavaja/provider/servico_provider.dart';
import 'package:provider/provider.dart';

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

  void save() {
    final isValid = _form.currentState?.validate();

    if (isValid!) {
      _form.currentState!.save();

      Provider.of<ServicoProvider>(context, listen: false).createServico(
          servico?.nome ?? '',
          servico?.valor ?? 0,
          servico?.tamCarro ?? '',
          servico?.tempServico ?? 0,
          servico?.ativo ?? false);
      Navigator.of(context).pop();
    }
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
                    value: servico?.ativo ?? false,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (bool? value) {
                      setState(() {
                        servico?.ativo = value;
                      });
                    }),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Salvar'),
                ),
              ],
            )),
      ),
    );
  }
}
