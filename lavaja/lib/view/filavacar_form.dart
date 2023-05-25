import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/models/contratarservico.dart';
import 'package:provider/provider.dart';

import '../provider/contratarservico_provider.dart';
import '../provider/home_donocarro_provider.dart';

class Filalavacar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fila')),
      body: ChangeNotifierProvider<ContratarServicoProvider>(
        create: (context) =>
            ContratarServicoProvider(service: ContratarServicoService()),
        child: Consumer<ContratarServicoProvider>(
          builder: (_, data, __) => Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: data.contratarServico.length,
                      itemBuilder: (context, index) {
                        final item = data.contratarServico[index];
                        return ListTile(
                          title: GestureDetector(
                            onTap: () {
                              // Ação a ser executada quando o ícone for clicado
                              print('Ícone clicado!');
                            },
                            child: Icon(Icons.car_crash),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
