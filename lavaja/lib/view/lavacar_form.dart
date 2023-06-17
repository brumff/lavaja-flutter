import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/auth_service.dart';
import 'package:lavaja/provider/donocarro_provider.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/donocarro.dart';
import '../textinputformatter.dart';

class LavaCarForm extends StatefulWidget {
  @override
  State<LavaCarForm> createState() => _LavaCarFormState();
}

class _LavaCarFormState extends State<LavaCarForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  final TextEditingController _senhaController = TextEditingController();
  String? _ConfSenha;
  bool isLoading = true;
  String? _selectedOption;
  String? _senhaError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LavacarProvider>(context, listen: false)
        .getLavacar()
        .whenComplete(() {
      _formData['cnpj'] =
          Provider.of<LavacarProvider>(context, listen: false).usuario?.cnpj ??
              '';
      _formData['nome'] =
          Provider.of<LavacarProvider>(context, listen: false).usuario?.nome ??
              '';
      _formData['logradouro'] =
          Provider.of<LavacarProvider>(context, listen: false)
                  .usuario
                  ?.logradouro ??
              '';
      _formData['numero'] = Provider.of<LavacarProvider>(context, listen: false)
              .usuario
              ?.numero ??
          '';
      _formData['complemento'] =
          Provider.of<LavacarProvider>(context, listen: false)
                  .usuario
                  ?.complemento ??
              '';
      _formData['bairro'] = Provider.of<LavacarProvider>(context, listen: false)
              .usuario
              ?.bairro ??
          '';
      _formData['cidade'] = Provider.of<LavacarProvider>(context, listen: false)
              .usuario
              ?.cidade ??
          '';
      _formData['cep'] =
          Provider.of<LavacarProvider>(context, listen: false).usuario?.cep ??
              '';
      _formData['telefone1'] =
          Provider.of<LavacarProvider>(context, listen: false)
                  .usuario
                  ?.telefone1 ??
              '';
      _formData['telefone2'] =
          Provider.of<LavacarProvider>(context, listen: false)
                  .usuario
                  ?.telefone2 ??
              '';
      _formData['email'] =
          Provider.of<LavacarProvider>(context, listen: false).usuario?.email ??
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
        title: Text('Lava Car'),
        leading: IconButton(
            onPressed: () {
              if (_formData['nome']!.isEmpty) {
                Modular.to.navigate(AppRoutes.LOGIN);
              } else {
                Modular.to.navigate(AppRoutes.HOMELAVACAR);
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
                    initialValue: _formData['cnpj'],
                    decoration: InputDecoration(labelText: 'CNPJ'),
                    inputFormatters: [cnpjMaskFormatter],
                    onChanged: (value) => _formData['cnpj'] = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    }),
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
                TextFormField(
                  initialValue: _formData['logradouro'],
                  decoration: InputDecoration(labelText: 'Logradouro'),
                  onChanged: (value) => _formData['logradouro'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['numero'],
                  decoration: InputDecoration(labelText: 'Nº'),
                  onChanged: (value) => _formData['numero'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['complemento'],
                  decoration: InputDecoration(labelText: 'Complemento'),
                  onChanged: (value) => _formData['complemento'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['bairro'],
                  decoration: InputDecoration(labelText: 'Bairro'),
                  onChanged: (value) => _formData['bairro'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['cidade'],
                  decoration: InputDecoration(labelText: 'Cidade'),
                  onChanged: (value) => _formData['cidade'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['cep'],
                  decoration: InputDecoration(labelText: 'CEP'),
                  inputFormatters: [cepMaskFormatter],
                  onChanged: (value) => _formData['cep'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['telefone1'],
                  decoration: InputDecoration(labelText: 'Telefone'),
                  inputFormatters: [phoneMaskFormatter],
                  onChanged: (value) => _formData['telefone1'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['telefone2'],
                  decoration: InputDecoration(labelText: 'Telefone (Opcional)'),
                  inputFormatters: [phoneMaskFormatter],
                  onChanged: (value) => _formData['telefone2'] = value,
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
                          Provider.of<LavacarProvider>(context, listen: false)
                              .updateLavacar(
                                  _formData['cnpj'] ?? '',
                                  _formData['nome'] ?? '',
                                  _formData['logradouro'] ?? '',
                                  _formData['numero'] ?? '',
                                  _formData['complemento'] ?? '',
                                  _formData['bairro'] ?? '',
                                  _formData['cidade'] ?? '',
                                  _formData['cep'] ?? '',
                                  _formData['telefone1'] ?? '',
                                  _formData['telefone2'] ?? '',
                                  _formData['email'] ?? '');
                                  _edicaoRealizada(context);
                        } else {
                          Provider.of<LavacarProvider>(context, listen: false)
                              .createLavacar(
                                  _formData['cnpj'] ?? '',
                                  _formData['nome'] ?? '',
                                  _formData['logradouro'] ?? '',
                                  _formData['numero'] ?? '',
                                  _formData['complemento'] ?? '',
                                  _formData['bairro'] ?? '',
                                  _formData['cidade'] ?? '',
                                  _formData['cep,'] ?? '',
                                  _formData['telefone1'] ?? '',
                                  _formData['telefone2'] ?? '',
                                  _formData['email'] ?? '',
                                  _formData['senha'] ?? '',
                                  _formData['confSenha'] ?? '');
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

void _edicaoRealizada(BuildContext context) {
  // Aqui você pode salvar o cadastro e exibir o snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Edição realizada com sucesso!'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green, // Definindo a cor de fundo do SnackBar
      //contentTextStyle: TextStyle(color: Colors.white),
    ),
  );
}