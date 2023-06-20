
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => __SplashState();
}

class __SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500)).whenComplete(() {
      Modular.to.navigate('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor:
              0.5,
          child: Image.asset('assets/images/icone_carro.png'),
        ),
      ),
    );
  }
}
