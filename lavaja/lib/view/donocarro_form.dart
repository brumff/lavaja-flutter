import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lavaja/provider/donocarro_provider.dart';
import 'package:provider/provider.dart';

import '../models/donocarro.dart';

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
  DonoCarro? donoCarro;
  final Map<String, String> _formData = {};

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
                  decoration: InputDecoration(labelText: 'Nome'),
                  onChanged: (value) => _formData['nome'] = value,
                ),
                /*DropdownButtonFormField<String>(
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
                  },
                );
              },
              decoration: InputDecoration(
                labelText: 'Genero',
                border: null,
              ),
            ),*/
                TextFormField(
                  decoration: InputDecoration(labelText: 'Genero'),
                  onChanged: (value) => _formData['genero'] = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Telefone'),
                  onChanged: (value) => _formData['telefone'] = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (value) => _formData['email'] = value,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Senha'),
                  onChanged: (value) => _formData['senha'] = value,
                ),
                TextFormField(
                  obscureText: true,
                  decoration:
                      InputDecoration(labelText: 'Confirmação da senha'),
                  onChanged: (value) => _formData['confSenha'] = value,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () {
                      final isValid = _form.currentState?.validate();

                      if(isValid!){
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
