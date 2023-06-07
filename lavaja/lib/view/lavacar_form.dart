import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/models/lavacar.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:provider/provider.dart';

import '../components/disponibilidade_component.dart';
import '../data/auth_service.dart';
import '../routes/app_routes.dart';
import '../textinputformatter.dart';

class LavacarForm extends StatefulWidget {
  @override
  State<LavacarForm> createState() => _LavacarFormState();
}

class _LavacarFormState extends State<LavacarForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  bool _isAtivo = false;
  TimeOfDay _horaInicio = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _horaFim = TimeOfDay(hour: 0, minute: 0);
  final TextEditingController _senhaController = TextEditingController();
  String? _ConfSenha;
  Lavacar lavacar = Lavacar();
  bool isLoading = true;

  // final Map<String, dynamic> _formData = {};
  //bool isEditing = true;
  @override
  initState() {
    super.initState();
    Provider.of<LavacarProvider>(context, listen: false)
        .getLavacar()
        .whenComplete(() {
      _formData['cnpj'] =
          Provider.of<LavacarProvider>(context, listen: false).usuario?.cnpj ??
              '';
      print(_formData['cnpj']);
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
        title: Text('Lava car'),
        leading: IconButton(onPressed: () {
           if (_formData['nome']!.isEmpty) {
              Modular.to.navigate(AppRoutes.LOGIN);
            } else {
              Modular.to.navigate(AppRoutes.HOMELAVACAR);
            }
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                /* SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                      'https://img.freepik.com/vetores-gratis/ilustracao-de-galeria-icone_53876-27002.jpg?w=740&t=st=1679449312~exp=1679449912~hmac=ee1fc64f18337be42c14e1f416549d65b7c0674f7d4a074b156ac936e5a54283'),
                ),*/
                TextFormField(
                  //enabled: !isEditing,
                  initialValue: _formData['cnpj'],
                  decoration: InputDecoration(labelText: 'CNPJ'),
                  inputFormatters: [cnpjMaskFormatter],
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['cnpj'] = value,
                ),
                TextFormField(
                  //enabled: !isEditing,
                  initialValue: _formData['nome'],
                  decoration: InputDecoration(labelText: 'Nome'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['nome'] = value,
                ),
                TextFormField(
                  //enabled: !isEditing,
                  initialValue: _formData['logradouro'],
                  decoration: InputDecoration(labelText: 'Logradouro'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['logradouro'] = value,
                ),
                TextFormField(
                  //enabled: !isEditing,
                  initialValue: _formData['numero'],
                  decoration: InputDecoration(labelText: 'Nº'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['numero'] = value,
                ),
                TextFormField(
                  //enabled: !isEditing,
                  initialValue: _formData['complemento'],
                  decoration: InputDecoration(labelText: 'Complemento'),
                  //fazer validação CNPJ, formatação CNPJ
                  onChanged: (value) => _formData['complemento'] = value,
                ),
                TextFormField(
                  //enabled: !isEditing,
                  initialValue: _formData['bairro'],
                  decoration: InputDecoration(labelText: 'Bairro'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['bairro'] = value,
                ),
                TextFormField(
                  //enabled: !isEditing,
                  initialValue: _formData['cidade'],
                  decoration: InputDecoration(labelText: 'Cidade'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['cidade'] = value,
                ),
                TextFormField(
                  //enabled: !isEditing,
                  initialValue: _formData['cep'],
                  decoration: InputDecoration(labelText: 'CEP'),
                  inputFormatters: [cepMaskFormatter],
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['cep'] = value,
                ),
                TextFormField(
                  //enabled: !isEditing,
                  initialValue: _formData['telefone1'],
                  decoration: InputDecoration(labelText: 'Telefone'),
                  inputFormatters: [phoneMaskFormatter],
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['telefone1'] = value,
                ),
                TextFormField(
                  //enabled: !isEditing,
                  initialValue: _formData['telefone2'],
                  decoration: InputDecoration(labelText: 'Telefone Opcional'),
                  inputFormatters: [phoneMaskFormatter],
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['telefone2'] = value,
                ),
                TextFormField(
                  //enabled: !isEditing,
                  initialValue: _formData['email'],
                  decoration: InputDecoration(labelText: 'Email'),
                  //fazer validação CNPJ, formatação CNPJ
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Campo obrigatorio';
                    }
                    return null;
                  },
                  onChanged: (value) => _formData['email'] = value,
                ),
                Visibility(
                  visible: AuthService.token == null,
                  child: TextFormField(
                      //  initialValue: _formData['Senha'],
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
                      //initialValue: _formData['confSenha'],
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
                        }
                        Modular.to.navigate(AppRoutes.LOGIN);
                        _cadastroRealizado(context);
                      }
                    },
                    child: Text(
                        'Salvar')), //Text(isEditing? 'Editar' : 'Salvar')),
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
