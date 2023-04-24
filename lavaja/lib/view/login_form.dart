import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../data/auth_service.dart';
import '../routes/app_routes.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

enum Perfil { donoCarro, lavaCar }

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  Perfil? _perfil = Perfil.donoCarro;
  AuthService _authService = AuthService();

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    final email = _emailController.text;
    final password = _passwordController.text;
    final perfil = _perfil == Perfil.donoCarro ? 'donoCarro' : 'lavaCar';

    try {
      if (perfil == 'donoCarro') {
        await _authService.login(email, password);
      } else if (perfil == 'lavaCar') {
        await _authService.login(email, password);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          //não ta apresentando mensagem de sucesso
          content: Text('Login realizado com sucesso'),
          backgroundColor: Colors.green, // alterado para verde
        ),
      );
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushNamed(AppRoutes.HOME, arguments: null);
    } catch (e) {
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
        title: Text('Login'),
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
                child: Image.network(
                    'https://images.vexels.com/media/users/3/146245/isolated/preview/056a110c18e9cf64b16b0dabb87926df-icone-de-carro-com-bolhas.png'),
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
                              value: Perfil.donoCarro,
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
                            value: Perfil.lavaCar,
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
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Senha",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Row(
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
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.DONOCARRO, arguments: null);
                },
                child: Text('Cadastre-se dono do carro',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue)),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.LAVACAR, arguments: null);
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
