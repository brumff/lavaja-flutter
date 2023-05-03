import 'dart:js';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:lavaja/view/donocarro_form.dart';
import 'package:lavaja/view/home_donocarro.dart';
import 'package:lavaja/view/lavacar_form.dart';
import 'package:lavaja/view/login_form.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => LoginForm()),
        ChildRoute(AppRoutes.LOGIN, child: (context, args) => LoginForm()),
        ChildRoute(
          AppRoutes.DONOCARRO,
          child: (context, args) => DonoCarroForm(),
        ),
        ChildRoute(AppRoutes.LAVACAR, child: (context, args) => LavacarForm()),
        ChildRoute(AppRoutes.HOME, child: (context, args) => HomeDonoCarro()),
        ChildRoute(
          AppRoutes.EDITDONOCARRO,
          child: (context, args) => DonoCarroForm(
          ),
        )
      ];
}
