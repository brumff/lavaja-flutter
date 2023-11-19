import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/auth_service.dart';
import 'package:lavaja/provider/donocarro_provider.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../uteis/textinputformatter.dart';
import '../uteis/validarcpf.dart';

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
  bool _senhaVisivel = false;
  bool _senhaVisivel2 = false;

  List<String> _genero = [
    'Feminino',
    'Masculino',
    'Outro',
  ];

  bool _aceitouTermo = false;

  void _abrirModalTermoDeUso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('TERMO DE USO'),
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
                        '7. Lei Aplicável: Estes Termos de Uso serão regidos e interpretados de acordo com as leis do Brasil sem levar em consideração os conflitos de princípios legais. Se você tiver alguma dúvida ou preocupação sobre estes Termos de Uso, entre em contato conosco em brunameiraf@gmail.com.\n\n',
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

  @override
  void initState() {
    if (AuthService.token != null) {
      super.initState();
      Provider.of<DonoCarroProvider>(context, listen: false)
          .getDonoCarro()
          .whenComplete(() {
        _formData['nome'] =
            Provider.of<DonoCarroProvider>(context, listen: false)
                    .usuario
                    ?.nome ??
                '';
        _formData['cpf'] =
            Provider.of<DonoCarroProvider>(context, listen: false)
                    .usuario
                    ?.cpf ??
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
        _selectedOption = Provider.of<DonoCarroProvider>(context, listen: false)
            .usuario
            ?.genero;
        _formData['genero'] = _selectedOption ?? 'Outro';
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
        title:
            Text(AuthService.token == null ? 'DONO DO CARRO' : 'EDITAR PERFIL'),
        leading: IconButton(
            onPressed: () {
              if (AuthService.token == null) {
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
                TextFormField(
                  initialValue: _formData['cpf'],
                  decoration: InputDecoration(labelText: 'CPF'),
                  inputFormatters: [cpfMaskFormatter],
                  onChanged: (value) => _formData['cpf'] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (!isValidCPF(value)) {
                      return 'CPF inválido';
                    }
                    return null; // CPF válido
                  },
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
                  decoration: InputDecoration(labelText: 'Celular'),
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
                  enabled: AuthService.token != null ,
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
                      obscureText:  !_senhaVisivel2,
                      decoration: InputDecoration(
                          labelText: 'Confirmação da senha',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _senhaVisivel2 = !_senhaVisivel2;
                              });
                            },
                            icon: Icon(
                              _senhaVisivel2
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
                    final isValid = _form.currentState?.validate();

                    if (isValid!) {
                      _form.currentState!.save();
                      if (AuthService.token != null) {
                        Provider.of<DonoCarroProvider>(context, listen: false)
                            .updateDonoCarro(
                          _formData['nome'] ?? '',
                          _formData['cpf'] ?? '',
                          _formData['telefone'] ?? '',
                          _formData['genero'] ?? '',
                        );
                        _edicaoRealizada(context);
                      } else {
                        if (_aceitouTermo == true) {
                          final donocarroMessage =
                              await Provider.of<DonoCarroProvider>(context,
                                      listen: false)
                                  .createDonoCarro(
                            _formData['nome'] ?? '',
                            _formData['cpf'] ?? '',
                            _formData['telefone'] ?? '',
                            _formData['email'] ?? '',
                            _formData['genero'] ?? '',
                            _formData['senha'] ?? '',
                            _formData['confSenha'] ?? '',
                          );

                          if (donocarroMessage ==
                              'Cadastro realizado com sucesso!') {
                            _cadastroRealizado(context, donocarroMessage ?? '');
                            Modular.to.navigate(AppRoutes.LOGIN);
                          } else {
                            _erro(context, donocarroMessage ?? '');
                          }
                        } else {
                          _erroTermo(context);
                        }
                      }
                    }
                  },
                  child: Text('Salvar'),
                )
              ],
            )),
      ),
    );
  }
}

void _cadastroRealizado(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
    ),
  );
}

void _erro(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
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

void _erroTermo(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('É obrigatório aceitar os termos de uso para continuar.'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ),
  );
}
