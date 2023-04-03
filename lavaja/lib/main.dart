import 'package:flutter/material.dart';
import 'package:lavaja/data/lavacar_service.dart';
import 'package:lavaja/provider/donocarro_provider.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:lavaja/view/donocarro_form.dart';
import 'package:lavaja/view/lavacar_form.dart';
import 'package:provider/provider.dart';

import 'data/donocarro_service.dart';

void main() {
  runApp(MyApp());
}
//verificar com o felipe como usar varios providers
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => DonoCarroProvider(service: DonoCarroService()),
          
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Colors.blue),
        home: DonoCarroForm(),
        routes: {
          AppRoutes.LAVACAR: (_) => LavacarForm(),
          AppRoutes.DONOCARRO: (_) => DonoCarroForm(),
        },
      ),
    );
  }
}
