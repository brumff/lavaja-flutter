import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/servico_service.dart';
import 'package:provider/provider.dart';

import '../provider/servico_provider.dart';
import '../routes/app_routes.dart';

class ListaServicoForm extends StatelessWidget {
  static const appTitle = 'Lista de Serviços';

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
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Modular.to.navigate(AppRoutes.HOMELAVACAR);
              }),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
              Modular.to.navigate(AppRoutes.CREATESERVICO);
            })
          ],
        ),
        body: ChangeNotifierProvider<ServicoProvider>(
          create: (context) => ServicoProvider(service: ServicoService()),
          child: Consumer<ServicoProvider>(
              builder: (_, data, __) => Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.meusServicos.length,
                              itemBuilder: (context, index) {
                                final item = data.meusServicos[index];
                                return ListTile(
                                  title: Text(item.nome ?? ''),
                                  subtitle: Text(
                                      'R\$ ${item.valor?.toStringAsFixed(2).replaceAll('.', ',')} - ${item.tempServico}'),
                                  leading: Icon(Icons.car_crash),
                                  trailing: Icon(Icons.edit),
                                  onTap: () {
                                   Modular.to.pushNamed('/servico/${item.id}');
                                   print(item.id);
                                  },
                                );
                              }))
                    ],
                  )),
        ));
  }
}
