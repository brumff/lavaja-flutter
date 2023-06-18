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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ServicoProvider>(context, listen: false).loadServico();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Modular.to.navigate(AppRoutes.HOMELAVACAR);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Modular.to.navigate(AppRoutes.CREATESERVICO);
            },
          ),
        ],
      ),
      body: Consumer<ServicoProvider>(
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
                      'R\$ ${item.valor?.toStringAsFixed(2).replaceAll('.', ',')} - ${item.tempServico} minutos',
                    ),
                    leading: Icon(Icons.car_crash),
                    trailing: Icon(Icons.edit),
                    onTap: () {
                      Modular.to.pushNamed('/servico/${item.id}');
                      print(item.id);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}