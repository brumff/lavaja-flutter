import 'package:flutter/material.dart';

class DetalhesLavacarForm extends StatefulWidget {

  @override
  State<DetalhesLavacarForm> createState() => _DetalhesLavacarFormState();
}

class _DetalhesLavacarFormState extends State<DetalhesLavacarForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Nome do lavacar'),
       ),
       body: Column(
          children: [
            Text('Funcionando')
          ],
       ),
    );
  }
}