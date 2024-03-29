import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/lavacar_service.dart';
import 'package:lavaja/provider/donocarro_provider.dart';
import 'package:provider/provider.dart';

import '../data/auth_service.dart';
import '../data/donocarro_service.dart';
import '../data/firebase_api.dart';
import '../models/lavacar.dart';
import '../provider/lavacar_provider.dart';
import '../routes/app_routes.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

enum Perfil { ROLE_DONOCARRO, ROLE_LAVACAR }

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  Perfil? _perfil = Perfil.ROLE_DONOCARRO;
  AuthService _authService = AuthService();
  bool _senhaVisivel = false;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await _authService.login(email, password);

      if (_perfil.toString().split('.')[1] == AuthService.authority) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login realizado com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _isLoading = false;
        });

        if (AuthService.authority == "ROLE_DONOCARRO") {
          Modular.to.navigate(AppRoutes.HOMEDONOCARRO);
          try {
            final firebaseToken = await _firebaseMessaging.getToken();
            Provider.of<DonoCarroProvider>(context, listen: false)
                .tokenFirebase(firebaseToken);
            print(firebaseToken);
          } catch (error) {}
        } else if (AuthService.authority == "ROLE_LAVACAR") {
          try {
            Provider.of<LavacarProvider>(context, listen: false)
                .getLavacar()
                .then((_) {
              bool aberto = Provider.of<LavacarProvider>(context, listen: false)
                      .usuario
                      ?.aberto ??
                  false;
              print(aberto);
              Modular.to.navigate(AppRoutes.HOMELAVACAR);
            });
          } catch (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Erro ao obter informações do Lavacar'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao realizar login'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao realizar login'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/images/icone_carro.png'),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 45),
                    Expanded(
                      child: Row(
                        children: [
                          Radio(
                              value: Perfil.ROLE_DONOCARRO,
                              groupValue: _perfil,
                              onChanged: (Perfil? value) {
                                setState(() {
                                  _perfil = value;
                                });
                              }),
                          Expanded(
                            child: Text('Dono do Carro'),
                          )
                        ],
                      ),
                      flex: 1,
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Radio(
                            value: Perfil.ROLE_LAVACAR,
                            groupValue: _perfil,
                            onChanged: (Perfil? value) {
                              setState(() {
                                _perfil = value;
                              });
                            }),
                        Expanded(
                          child: Text('Lava car '),
                        )
                      ],
                    ))
                  ],
                ),
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: !_senhaVisivel,
                decoration: InputDecoration(
                    labelText: "Senha",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _senhaVisivel = !_senhaVisivel;
                        });
                      },
                      icon: Icon(
                        _senhaVisivel ? Icons.visibility : Icons.visibility_off,
                      ),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              /*Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Divider(
                color: Colors.black,
                height: 2,
              ),*/
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Modular.to.navigate(AppRoutes.DONOCARRO);
                },
                child: Text('Cadastre-se dono do carro',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue)),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Modular.to.navigate(AppRoutes.LAVACAR);
                },
                child: Text('Cadastre-se lava car',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue)),
              ),
              SizedBox(height: 16),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                          //Navigator.of(context).pushNamed(AppRoutes.HOME, arguments: null);
                        }
                      },
                      child: Text("Entrar"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
