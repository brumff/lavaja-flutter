import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
        title: Text('SERVIÇO CONTRATADO'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.check_circle, size: 96.0, color: Colors.green),
            ),
            SizedBox(height: 20.0), 
            Text(
              'Serviço contratado com sucesso!',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0), 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
               Modular.to.navigate('/home-donocarro');
                  },
                  child: Text('Home'),
                ),
                SizedBox(width: 20.0), 
                ElevatedButton(
                  onPressed: () {
                   Modular.to.navigate('/historico-donocarro');
                  },
                  child: Text('Histórico'),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: MenuDonoCarroComponent(),
    );
  }
}