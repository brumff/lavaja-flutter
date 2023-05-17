import 'dart:js';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:lavaja/view/donocarro_form.dart';
import 'package:lavaja/view/home_donocarro.dart';
import 'package:lavaja/view/home_lavacar.dart';
import 'package:lavaja/view/lavacar_form.dart';
import 'package:lavaja/view/listaservico_form.dart';
import 'package:lavaja/view/login_form.dart';
import 'package:lavaja/view/servico_form.dart';

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
        ChildRoute(
          AppRoutes.LAVACAR,
          child: (context, args) => LavacarForm(),
        ),
        ChildRoute(AppRoutes.LAVACAR, child: (context, args) => LavacarForm()),
        ChildRoute(AppRoutes.HOMEDONOCARRO,
            child: (context, args) => HomeDonoCarro()),
        ChildRoute(AppRoutes.HOMELAVACAR,
            child: (context, args) => HomeLavaCar()),
        ChildRoute(
          AppRoutes.EDITDONOCARRO,
          child: (context, args) => DonoCarroForm(),
        ),
        ChildRoute(
          AppRoutes.EDITLAVACAR,
          child: (context, args) => LavacarForm(),
        ),
        ChildRoute(
          AppRoutes.LISTASERVICO,
          child: (context, args) => ListaServicoForm(),
        ),
        ChildRoute(
          AppRoutes.CREATESERVICO,
          child: (context, args) => ServicoForm(isEditing: false,),
        ),
        ChildRoute(
          AppRoutes.EDITSERVICO,
          child: (context, args) => ServicoForm(
            id:  args.params['id'],
            isEditing: true,
          ),
        ),
      ];
}
