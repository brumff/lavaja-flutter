import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocode/geocode.dart';
import 'package:lavaja/data/auth_service.dart';
import 'package:lavaja/data/lavacar_service.dart';
import 'package:lavaja/models/lavacar.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../uteis/textinputformatter.dart';

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
  //final provider = LavacarProvider(service: LavacarService());
  bool _senhaVisivel = false;
  bool _aceitouTermo = false;
  final TextEditingController _enderecoController = TextEditingController();

  void _abrirModalTermoDeUso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Termo de Uso'),
          content: SingleChildScrollView(
            child: RichText(
              text: TextSpan(
                text: 'Última atualização: 17/07/2023\n\n',
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '1. Aceitação dos Termos: Ao utilizar o aplicativo "Lavaja", você concorda em cumprir e ficar vinculado a estes Termos de Uso. Se você não concordar com algum destes termos, não use o aplicativo.\n\n',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text:
                        '2. Uso do Aplicativo: O aplicativo "Lavaja" é destinado apenas para uso pessoal e não comercial. Você concorda em não modificar, copiar, distribuir, transmitir, exibir, executar, reproduzir, publicar, licenciar, criar trabalhos derivados, transferir ou vender qualquer informação, software, produtos ou serviços obtidos através do aplicativo "Lavaja".\n\n',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextSpan(
                    text:
                        '3. Propriedade Intelectual: Todo o conteúdo presente ou disponibilizado através do aplicativo "Lavaja", incluindo, mas não se limitando a textos, gráficos, logotipos, ícones, imagens, clipes de áudio, downloads digitais e compilações de dados, é de propriedade exclusiva do "Lavaja" ou de seus fornecedores e está protegido pelas leis de direitos autorais e outras leis de propriedade intelectual.\n\n',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextSpan(
                    text:
                        '4. Privacidade: Ao utilizar o aplicativo "Lavaja", você concorda com nossa Política de Privacidade [link para a política de privacidade], que descreve como coletamos, usamos e compartilhamos suas informações.\n\n',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextSpan(
                    text:
                        '5. Limitação de Responsabilidade: O aplicativo "Lavaja" é fornecido "como está" e não oferece garantias de qualquer tipo, expressas ou implícitas. O "MeuApp" não se responsabiliza por danos diretos, indiretos, incidentais, consequenciais ou outros danos decorrentes do uso ou incapacidade de usar o aplicativo.\n\n',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextSpan(
                    text:
                        '6. Alterações nos Termos: O "Lavaja" pode revisar estes Termos de Uso a qualquer momento, sem aviso prévio. O uso contínuo do aplicativo após a publicação de quaisquer alterações nos Termos de Uso será considerado como aceitação dessas alterações.\n\n',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextSpan(
                    text:
                        '7. Lei Aplicável: Estes Termos de Uso serão regidos e interpretados de acordo com as leis do Brail sem levar em consideração os conflitos de princípios legais. Se você tiver alguma dúvida ou preocupação sobre estes Termos de Uso, entre em contato conosco em brunameiraf@gmail.com.\n\n',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextSpan(
                    text: 'Agradecemos por utilizar o aplicativo "Lavaja"!',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  _getCoordinates() async {
    GeoCode geoCode = GeoCode();

    try {
      Coordinates coordinates = await geoCode.forwardGeocoding(
          address: _enderecoController.text =
              '${_formData['numero'] ?? ''} ${_formData['rua'] ?? ''}, ${_formData['cidade'] ?? ''}');

      // Verifique se o widget foi descartado antes de atualizar o estado
      setState(() {
        _formData['longitude'] = coordinates.latitude.toString();
        _formData['latitude'] = coordinates.longitude.toString();
        print(_formData['longitude']);
        print(_formData['latitude']);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _enderecoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (AuthService.token != null) {
      super.initState();
      Provider.of<LavacarProvider>(context, listen: false)
          .getLavacar()
          .whenComplete(() {
        _formData['cnpj'] = Provider.of<LavacarProvider>(context, listen: false)
                .usuario
                ?.cnpj ??
            '';
        _formData['nome'] = Provider.of<LavacarProvider>(context, listen: false)
                .usuario
                ?.nome ??
            '';
        _formData['rua'] =
            Provider.of<LavacarProvider>(context, listen: false).usuario?.rua ??
                '';
        _formData['numero'] =
            Provider.of<LavacarProvider>(context, listen: false)
                    .usuario
                    ?.numero ??
                '';
        _formData['bairro'] =
            Provider.of<LavacarProvider>(context, listen: false)
                    .usuario
                    ?.bairro ??
                '';
        _formData['cidade'] =
            Provider.of<LavacarProvider>(context, listen: false)
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
            Provider.of<LavacarProvider>(context, listen: false)
                    .usuario
                    ?.email ??
                '';
        setState(() {
          isLoading = false;
        });
      });
    } else {
      setState(() {
        isLoading = false;
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
        title: Text('Lava Car'),
        leading: IconButton(
            onPressed: () {
              if (AuthService.token == null) {
                Modular.to.navigate(AppRoutes.LOGIN);
              } else {
                Modular.to.navigate(AppRoutes.CREATEFILA);
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
                  initialValue: _formData['rua'],
                  decoration: InputDecoration(labelText: 'Rua'),
                  onChanged: (value) {
                    _formData['rua'] = value;
                    // _getCoordinates();
                  },
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
                  onChanged: (value) {
                    _formData['numero'] = value;
                    // _getCoordinates();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                /*TextFormField(
                  initialValue: _formData['complemento'],
                  decoration: InputDecoration(labelText: 'Complemento'),
                  onChanged: (value) => _formData['complemento'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),*/
                TextFormField(
                  initialValue: _formData['bairro'],
                  decoration: InputDecoration(labelText: 'Bairro'),
                  onChanged: (value) {
                    _formData['bairro'] = value;
                    //_getCoordinates();
                  },
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
                  onChanged: (value) {
                    _formData['cidade'] = value;
                    //_getCoordinates();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                /*TextFormField(
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
                ),*/
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
                      controller: _senhaController,
                      obscureText: !_senhaVisivel,
                      decoration: InputDecoration(
                          labelText: 'Senha',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _senhaVisivel = !_senhaVisivel;
                              });
                            },
                            icon: Icon(
                              _senhaVisivel
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          )),
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
                      decoration: InputDecoration(
                          labelText: 'Confirmação da senha',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _senhaVisivel = !_senhaVisivel;
                              });
                            },
                            icon: Icon(
                              _senhaVisivel
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          )),
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
                Row(
                  children: [
                    Visibility(
                      visible: AuthService.token == null,
                      child: Checkbox(
                          value: _aceitouTermo,
                          onChanged: (bool? value) {
                            setState(() {
                              _aceitouTermo = value!;
                            });
                          }),
                    ),
                    Visibility(
                        visible: AuthService.token == null,
                        child: GestureDetector(
                          child: Text(
                            "Li e aceito os termos",
                            style: TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
                          onTap: _abrirModalTermoDeUso,
                        ))
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () async {
                      await _getCoordinates();
                      final isValid = _form.currentState?.validate();
                      if (isValid!) {
                        _form.currentState!.save();
                        if (AuthService.token != null) {
                          Provider.of<LavacarProvider>(context, listen: false)
                              .updateLavacar(
                                  _formData['cnpj'] ?? '',
                                  _formData['nome'] ?? '',
                                  _formData['rua'] ?? '',
                                  _formData['numero'] ?? '',
                                  _formData['complemento'] ?? '',
                                  _formData['bairro'] ?? '',
                                  _formData['cidade'] ?? '',
                                  _formData['cep'] ?? '',
                                  _formData['longitude'] ?? '',
                                  _formData['latitude'] ?? '',
                                  _formData['telefone1'] ?? '',
                                  _formData['telefone2'] ?? '',
                                  _formData['email'] ?? '');
                          _edicaoRealizada(context);
                        } else {
                          if (_aceitouTermo == true) {
                            Provider.of<LavacarProvider>(context, listen: false)
                                .createLavacar(
                                    _formData['cnpj'] ?? '',
                                    _formData['nome'] ?? '',
                                    _formData['rua'] ?? '',
                                    _formData['numero'] ?? '',
                                    _formData['complemento'] ?? '',
                                    _formData['bairro'] ?? '',
                                    _formData['cidade'] ?? '',
                                    _formData['cep'] ?? '',
                                    _formData['longitude'] ?? '',
                                    _formData['latitude'] ?? '',
                                    _formData['telefone1'] ?? '',
                                    _formData['telefone2'] ?? '',
                                    _formData['email'] ?? '',
                                    _formData['senha'] ?? '',
                                    _formData['confSenha'] ?? '');
                            Modular.to.navigate(AppRoutes.LOGIN);
                            _cadastroRealizado(context);
                          } else {
                            _erroTermo(context);
                          }
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

void _erroTermo(BuildContext context) {
  // Aqui você pode salvar o cadastro e exibir o snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('É obrigatório aceitar os termos de uso para continuar.'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red, // Definindo a cor de fundo do SnackBar
      //contentTextStyle: TextStyle(color: Colors.white),
    ),
  );
}
