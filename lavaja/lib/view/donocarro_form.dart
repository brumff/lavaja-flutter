import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/auth_service.dart';
import 'package:lavaja/provider/donocarro_provider.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/donocarro.dart';
import '../textinputformatter.dart';

class DonoCarroForm extends StatefulWidget {
  const DonoCarroForm({super.key, this.id});

  @override
  State<DonoCarroForm> createState() => _DonoCarroFormState();
  final String? id;
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
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DonoCarroProvider>(context, listen: false)
        .getDonoCarro()
        .whenComplete(() {
      _formData['nome'] = Provider.of<DonoCarroProvider>(context, listen: false)
              .usuario
              ?.nome ??
          '';
          _formData['telefone'] = Provider.of<DonoCarroProvider>(context, listen: false)
              .usuario
              ?.telefone ??
          '';
          _formData['email'] = Provider.of<DonoCarroProvider>(context, listen: false)
              .usuario
              ?.email ??
          '';
      setState(() {
        isLoading = false;
      });
    });
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
        title: Text('Dono do carro'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
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
                    }),
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
                TextFormField(
                  initialValue: _formData['telefone'],
                  decoration: InputDecoration(labelText: 'Telefone'),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [phoneMaskFormatter],
                  onChanged: (value) => _formData['telefone'] = value,
                ),
                TextFormField(
                  initialValue: _formData['email'],
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
                Visibility(
                  visible: AuthService.token == null,
                  child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Senha'),
                      onChanged: (value) => _formData['senha'] = value,
                      controller: _senhaController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        if (_ConfSenha != null && value != _ConfSenha) {
                          return 'As senhas não coincidem';
                        }
                        return null;
                      }),
                ),
                Visibility(
                  visible: AuthService.token == null,
                  child: TextFormField(
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
                      }),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () {
                      final isValid = _form.currentState?.validate();

                      if (isValid!) {
                        _form.currentState!.save();
                        if (AuthService.token != null) {
                          Provider.of<DonoCarroProvider>(context, listen: false)
                              .updateDonoCarro(
                            _formData['nome'] ?? '',
                            _formData['telefone'] ?? '',
                            _formData['genero'] ?? '',
                          );
                        } else {
                          Provider.of<DonoCarroProvider>(context, listen: false)
                              .createDonoCarro(
                            _formData['nome'] ?? '',
                            _formData['telefone'] ?? '',
                            _formData['email'] ?? '',
                            _formData['genero'] ?? '',
                            _formData['senha'] ?? '',
                            _formData['confSenha'] ?? '',
                          );
                        }
                        Modular.to.navigate(AppRoutes.HOME);
                      }
                      _cadastroRealizado(context);
                    },
                    child: Text('Cadastrar'))
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
      content: Text('Cadastro realizado com sucesso!'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green, // Definindo a cor de fundo do SnackBar
      //contentTextStyle: TextStyle(color: Colors.white),
    ),
  );
}
