import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/components/menu_donocarro_component.dart';
import 'package:lavaja/provider/veiculo_provider.dart';
import 'package:provider/provider.dart';

import '../routes/app_routes.dart';

class VeiculoLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MEUS VEÍCULOS'),
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.navigate(AppRoutes.CREATEVEICULO);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<VeiculoProvider>(builder: (_, data, __) {
        if (data.veiculos.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Você não possui nenhum veículo cadastrado.',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),
                Image.asset(
                  'assets/images/veiculos.png', 
                  height: 400, 
                ),
                SizedBox(height: 16), 
                ElevatedButton.icon(
                  onPressed: () {
                    Modular.to.navigate(AppRoutes.CREATEVEICULO);
                  },
                  icon: Icon(Icons.add),
                  label: Text('Cadastrar Veículo'),
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: data.veiculos.length,
            itemBuilder: (context, index) {
              final item = data.veiculos[index];
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Placa: ${item.placa} - ${item.modelo}'),
                    leading: Icon(Icons.directions_car),
                    trailing: Icon(Icons.edit),
                    onTap: () {
                      Modular.to.pushNamed('/veiculo/${item.id}');
                    },
                  ),
                  Divider(
                    height: 0,
                  ), // Adicione um Divider entre os itens
                ],
              );
            },
          );
        }
      }),
      drawer: MenuDonoCarroComponent(),
    );
  }
}
