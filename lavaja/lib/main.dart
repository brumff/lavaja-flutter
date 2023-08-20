import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/contratarservico_service.dart';
import 'package:lavaja/data/lavacar_service.dart';
import 'package:lavaja/provider/contratarservico_provider.dart';
import 'package:lavaja/provider/donocarro_provider.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:lavaja/view/donocarro_form.dart';
import 'package:lavaja/view/filalavacar2_form.dart';
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

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  initializeService();
   return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

/*Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString("hello", "world");


  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(minutes: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
             
      }
    }
    
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    String? device;
  
    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
        "device": device,
      },
    );
  });
}*/

class MyApp extends StatelessWidget {
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
          create: (ctx) => ContratarServicoProvider(service: ContratarServicoService()),
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
