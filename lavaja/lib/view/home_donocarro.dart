import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lavaja/data/servico_service.dart';
import 'package:lavaja/provider/donocarro_provider.dart';
import 'package:provider/provider.dart';

import '../provider/home_donocarro_provider.dart';

class HomeDonoCarro extends StatelessWidget {
  static const appTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ChangeNotifierProvider<HomeDonoCarroProvider>(
        create: (context) => HomeDonoCarroProvider(service: ServicoService()),
        child: Consumer<HomeDonoCarroProvider>(
          builder: (_, data, __) => Column(
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onSubmitted: (value) {
                    //quando usuario da entrer faz a pesquisa
                  },
                  decoration: InputDecoration(
                      label: Text('Digite seu endereço'),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          //quando usuario da entrer faz a pesquisa
                        },
                      )),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: data.servicos.length,
                  itemBuilder: (context, index) {
                    final item = data.servicos[index];
                    return ListTile(
                      title: Text(item.nome ?? ''),
                      subtitle: Text(
                          'R\$ ${item.valor?.toStringAsFixed(2).replaceAll('.', ',')} - ${item.tempServico}'),
                      leading: Icon(Icons.car_crash),
                      trailing: Icon(Icons.arrow_forward_ios_sharp),
                      onTap: () {
                        //para mudar de pagina, para mostrar as informações do serviço
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 55,
              color: Colors.blue,
            ),
            ListTile(
              title: const Text('Editar perfil'),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Listagem de pedidos'),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Alterar senha'),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sair', style: TextStyle(color: Colors.red),),
              trailing: Icon(Icons.exit_to_app, color: Colors.red),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
