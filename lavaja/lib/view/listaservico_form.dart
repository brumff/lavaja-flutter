import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../components/menu_lavacar_component.dart';
import '../provider/servico_provider.dart';
import '../routes/app_routes.dart';

class ListaServicoForm extends StatelessWidget {
  static const appTitle = 'LISTA DE SERVIÇO';

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
        /* leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Modular.to.navigate(AppRoutes.HOMELAVACAR);
          },
        ),*/
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
        builder: (_, data, __) {
          if (data.meusServicos.isEmpty) {
            return Center(
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nenhum serviço cadastrado.',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Image.asset('assets/images/servicos.png', 
                  height: 300, )
                ],
              ),
            );
          } else {
            return ListView.builder(
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
            );
          }
        },
      ),
      drawer: MenuLavacarComponent(),
    );
  }
}
