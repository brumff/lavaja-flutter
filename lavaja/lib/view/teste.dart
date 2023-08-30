import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lavaja/controller/teste_controller.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Texto'),
      ),
      body: ChangeNotifierProvider<LocalizacaoController>(
        create: (context) => LocalizacaoController(),
        child: Builder(
          builder: (context) {
            final local = context.watch<LocalizacaoController>();

            String mensagem = local.erro == '' ? 'Latitude: ${local.lat} | Longitude: ${local.long}' : local.erro;

            return Center(child: Text(mensagem),);
          },
        ),
      ),
    );
  }
}
