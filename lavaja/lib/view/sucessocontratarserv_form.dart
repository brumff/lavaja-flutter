import 'package:flutter/material.dart';
import 'package:lavaja/components/menu_donocarro_component.dart';

class SucessoContratarServ extends StatefulWidget {
 

  @override
  State<SucessoContratarServ> createState() => __SucessoContratarServState();
}

class __SucessoContratarServState extends State<SucessoContratarServ> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serviço contratado'),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Image.asset('assets/images/icone_carro.png'),
        ),
      ),
        drawer: MenuDonoCarroComponent(),
    );
  }
}
