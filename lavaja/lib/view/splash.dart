import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => __SplashState();
}

class __SplashState extends State<Splash> {
 /* @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500)).whenComplete(() {
      Modular.to.navigate('/login');
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: 0.5, // Fator de escala para reduzir a imagem pela metade
              child: Image.asset('assets/images/icone_carro.png'),
            ),
            Positioned(
              top: 0,
              child: Text(
                'Lavaja',
                style: TextStyle(
                  fontSize: 40, // Tamanho do texto
                  color: Color.fromRGBO(0, 43, 79, 1),
                  fontFamily: 'Hind Siliguri' 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
