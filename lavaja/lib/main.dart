import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/data/firebase_api.dart';
import 'package:lavaja/data/lavacar_service.dart';
import 'package:lavaja/firebase_options.dart';
import 'package:lavaja/provider/contratarservico_provider.dart';
import 'package:lavaja/provider/donocarro_provider.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:lavaja/view/donocarro_form.dart';
import 'package:lavaja/view/filavacar_form.dart';
import 'package:lavaja/view/home_donocarro.dart';
import 'package:lavaja/view/home_lavacar.dart';
import 'package:lavaja/view/lavacar_form.dart';
import 'package:lavaja/view/login_form.dart';
import 'package:lavaja/view/servico_form.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_module.dart';
import 'app_widget.dart';
import 'data/donocarro_service.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().iniNotification();
  await initializeDateFormatting('pt_BR', null);
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

class MyApp extends StatelessWidget {
  static String ip = 'http://192.168.1.20:8080';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LavacarProvider>(
          create: (ctx) => LavacarProvider(service: LavacarService()),
        ),
        ChangeNotifierProvider<DonoCarroProvider>(
          create: (ctx) => DonoCarroProvider(service: DonoCarroService()),
        ),
        ChangeNotifierProvider<ContratarServicoProvider>(
          create: (ctx) =>
              ContratarServicoProvider(service: ContratarServicoService()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Colors.blue),
        home: LoginForm(),
        routes: {
          AppRoutes.LAVACAR: (_) => LavaCarForm(),
          AppRoutes.DONOCARRO: (_) => DonoCarroForm(),
          AppRoutes.LOGIN: (_) => LoginForm(),
          AppRoutes.HOMEDONOCARRO: (_) => HomeDonoCarro(),
        },
      ),
    );
  }
}
