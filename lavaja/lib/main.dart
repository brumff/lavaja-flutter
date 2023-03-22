import 'package:flutter/material.dart';
import 'package:lavaja/data/lavacar_service.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:lavaja/view/lavacar_form.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => LavacarProvider(service: LavacarService()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Colors.blue),
        home: LavacarForm(),
        routes: {
          AppRoutes.LAVACAR:(_) => LavacarForm(),
        },
      ),
    );
  } 
}

