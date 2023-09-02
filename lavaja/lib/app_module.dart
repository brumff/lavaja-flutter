import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/routes/app_routes.dart';
import 'package:lavaja/view/buscaendereco.dart';
import 'package:lavaja/view/contratarservlavacar_form.dart';
import 'package:lavaja/view/detalheslavacar_form.dart';
import 'package:lavaja/view/donocarro_form.dart';
import 'package:lavaja/view/filavacar_form.dart';
import 'package:lavaja/view/historicoservico_lavacar.dart';
import 'package:lavaja/view/home_donocarro.dart';
import 'package:lavaja/view/home_lavacar.dart';
import 'package:lavaja/view/lavacar_form.dart';
import 'package:lavaja/view/listaservico_form.dart';
import 'package:lavaja/view/login_form.dart';
import 'package:lavaja/view/servico_form.dart';
import 'package:lavaja/view/splash.dart';
import 'package:lavaja/view/teste.dart';
import 'package:lavaja/view/veiculo_form.dart';
import 'package:lavaja/view/veiculo_lista.dart';

import 'controller/teste_controller.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [Bind((i) => LocalizacaoController())];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => Splash(),
            transition: TransitionType.upToDown),
        ChildRoute(AppRoutes.LOGIN,
            child: (context, args) => LoginForm(),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.DONOCARRO,
            child: (context, args) => DonoCarroForm(),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.LAVACAR,
            child: (context, args) => LavaCarForm(),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.HOMEDONOCARRO,
            child: (context, args) => HomeDonoCarro(),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.HOMELAVACAR,
            child: (context, args) => HomeLavaCar(),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.EDITDONOCARRO,
            child: (context, args) => DonoCarroForm(),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.EDITLAVACAR,
            child: (context, args) => LavaCarForm(),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.LISTASERVICO,
            child: (context, args) => ListaServicoForm(),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.CREATESERVICO,
            child: (context, args) => ServicoForm(
                  isEditing: false,
                ),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.EDITSERVICO,
            child: (context, args) => ServicoForm(
                  id: args.params['id'],
                  isEditing: true,
                ),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.CREATEFILA,
            child: (context, args) => Filalavacar(),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.HISTORICOLAVACAR,
            child: (context, args) => HistoricoServicoLavacar(),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.CONTRATARSERVLAVACAR,
            child: (context, args) => ContratarServLavacar(),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.DETALHESLAVACAR,
            child: (context, args) => DetalhesLavacarForm(),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.CREATEVEICULO,
            child: (context, args) => VeiculoForm(
                isEditing: false,
                ),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.LISTAVEICULOS,
            child: (context, args) => VeiculoLista(
                ),
            transition: TransitionType.leftToRight),
        ChildRoute(AppRoutes.EDITVEICULO,
            child: (context, args) => VeiculoForm(
                  id: args.params[
                    'id'],
                  isEditing: true,
                ),)
      ];
}
