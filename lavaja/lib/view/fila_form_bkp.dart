import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FilaForm extends StatefulWidget {
  @override
  State<FilaForm> createState() => _FilaFormState();
}

class _FilaFormState extends State<FilaForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fila'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
          child: Form(
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
              ),
              Spacer(),
              Column(
                children: [
                  Row(
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          iconTheme: IconThemeData(
                            color: Colors
                                .grey, // Altere a cor do ícone circle aqui
                          ),
                        ),
                        child: Icon(Icons.circle),
                      ),
                      Text('Aguardando'),
                    ],
                  ),
                  Row(
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          iconTheme: IconThemeData(
                            color: Colors
                                .green, // Altere a cor do ícone circle aqui
                          ),
                        ),
                        child: Icon(Icons.circle),
                      ),
                      Text('Em andamento'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
