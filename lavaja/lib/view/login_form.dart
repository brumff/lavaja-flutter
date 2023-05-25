import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/auth_service.dart';
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

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    final email = _emailController.text;
    final password = _passwordController.text;
    await _authService.login(email, password);

    //_perfil o que foi selecionado na tela, tirando o Perfil
    //print(_perfil.toString().split('.')[1]);
    //print('pula linha');
    //paga o que está setado no banco de dados no usuário
    //print(AuthService.authority);
    if (_perfil.toString().split('.')[1] == AuthService.authority) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          //não ta apresentando mensagem de sucesso
          content: Text('Login realizado com sucesso'),
          backgroundColor: Colors.green, // alterado para verde
        ),
      );
      print('Login realizado com sucesso');
      setState(() {
        _isLoading = false;
      });
      print(AuthService.authority);
      if (AuthService.authority == "ROLE_DONOCARRO") {
        Modular.to.navigate(AppRoutes.HOMEDONOCARRO);
      }
      if (AuthService.authority == "ROLE_LAVACAR") {
        Modular.to.navigate(AppRoutes.CREATEFILA);
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
