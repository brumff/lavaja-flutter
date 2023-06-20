import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/auth_service.dart';
import 'package:lavaja/provider/donocarro_provider.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../textinputformatter.dart';

class DonoCarroForm extends StatefulWidget {
  @override
  State<DonoCarroForm> createState() => _DonoCarroFormState();
}

class _DonoCarroFormState extends State<DonoCarroForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  final TextEditingController _senhaController = TextEditingController();
  String? _ConfSenha;
  bool isLoading = true;
  String? _selectedOption;
  String? _senhaError;

  List<String> _genero = [
    'Feminino',
    'Masculino',
    'Outro',
  ];

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
      _formData['telefone'] =
          Provider.of<DonoCarroProvider>(context, listen: false)
                  .usuario
                  ?.telefone ??
              '';
      _formData['email'] =
          Provider.of<DonoCarroProvider>(context, listen: false)
                  .usuario
                  ?.email ??
              '';
      _selectedOption  = Provider.of<DonoCarroProvider>(context, listen: false)
          .usuario
          ?.genero;
          _formData['genero'] = _selectedOption ?? 'Outro';
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
        leading: IconButton(
            onPressed: () {
              if (_formData['nome']!.isEmpty) {
                Modular.to.navigate(AppRoutes.LOGIN);
              } else {
                Modular.to.navigate(AppRoutes.HOMEDONOCARRO);
              }
            },
            icon: Icon(Icons.arrow_back)),
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
                    setState(() {
                      _selectedOption = value;
                      _formData['genero'] = _selectedOption!;
                      // atualize o valor no seu provider aqui:
                    });
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Selecione',
                    labelText: 'Gênero',
                    border: null,
                  ),
                ),
                TextFormField(
                  initialValue: _formData['telefone'],
                  decoration: InputDecoration(labelText: 'Telefone'),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [phoneMaskFormatter],
                  onChanged: (value) => _formData['telefone'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
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
                      onChanged: (value) {
                        _formData['senha'] = value;
                        setState(() {
                          if (value.length >= 6) {
                            _senhaError = null;
                          } else {
                            _senhaError =
                                'A senha deve conter pelo menos 6 caracteres';
                          }
                        });
                      },
                      controller: _senhaController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres';
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
                        } else if (value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres';
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
                           _edicaoRealizada(context);
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
                          Modular.to.navigate(AppRoutes.LOGIN);
                          _cadastroRealizado(context);
                        }
                      }
                    },
                    child: Text('Salvar'))
              ],
            )),
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

void _edicaoRealizada(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Edição realizada com sucesso!'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green, 
    ),
  );
}
