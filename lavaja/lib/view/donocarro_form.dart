import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lavaja/provider/donocarro_provider.dart';
import 'package:provider/provider.dart';

import '../models/donocarro.dart';
import '../textinputformatter.dart';

class DonoCarroForm extends StatefulWidget {
  @override
  State<DonoCarroForm> createState() => _DonoCarroFormState();
}

String? _selectedOption;

List<String> _genero = [
  'Feminino',
  'Masculino',
  'Outro',
];

class _DonoCarroFormState extends State<DonoCarroForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  final TextEditingController _senhaController = TextEditingController();
  String? _ConfSenha;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dono do carro'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 100,
                ),
                TextFormField(
                  initialValue: _formData['nome'],
                  decoration: InputDecoration(labelText: 'Nome'),
                  onChanged: (value) => _formData['nome'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                    }
                ),
                DropdownButtonFormField<String>(
                  value: _selectedOption,
                  items: _genero.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(
                      () {
                        _selectedOption = value;
                        _formData['genero'] = _selectedOption!;
                      },
                    );
                  },
                  decoration: InputDecoration(
                    labelText: 'Genero',
                    border: null,
                  ),
                ),
                /*TextFormField(
                  initialValue: _formData['Genero'],
                  decoration: InputDecoration(labelText: 'Genero'),
                  onChanged: (value) => _formData['genero'] = value,
                ),*/
                TextFormField(
                  initialValue: _formData['Telefone'],
                  decoration: InputDecoration(labelText: 'Telefone'),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [phoneMaskFormatter],
                  onChanged: (value) => _formData['telefone'] = value,
                ),
                TextFormField(
                  initialValue: _formData['Email'],
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (value) => _formData['email'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['Senha'],
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Senha'),
                  onChanged: (value) => _formData['senha'] = value,
                   controller: _senhaController ,
                   validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (_ConfSenha != null && value != _ConfSenha) {
                    return 'As senhas não coincidem';
                  }
                    return null;
                    }
                ),
                TextFormField(
                  initialValue: _formData['confSenha'],
                  obscureText: true,
                  decoration:
                      InputDecoration(labelText: 'Confirmação da senha'),
                  onChanged: (value) => _formData['confSenha'] = value,
                   validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (_senhaController.text != value) {
                    return 'As senhas não coincidem';
                  }
                    return null;
                    }
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () {
                      final isValid = _form.currentState?.validate();

                      if (isValid!) {
                        _form.currentState!.save();
                        Provider.of<DonoCarroProvider>(context, listen: false)
                            .createDonoCarro(
                          _formData['nome'] ?? '',
                          _formData['telefone'] ?? '',
                          _formData['genero'] ?? '',
                          _formData['email'] ?? '',
                          _formData['senha'] ?? '',
                          _formData['confSenha'] ?? '',
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Cadastrar'))
              ],
            )),
      ),
    );
  }
}
