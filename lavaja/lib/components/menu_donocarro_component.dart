import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lavaja/data/donocarro_service.dart';
import 'package:lavaja/data/lavacar_service.dart';
import 'package:provider/provider.dart';

import '../data/auth_service.dart';
import '../data/prefs_service.dart';
import '../provider/donocarro_provider.dart';
import '../routes/app_routes.dart';

class MenuDonoCarroComponent extends StatefulWidget {
  @override
  State<MenuDonoCarroComponent> createState() => _MenuDonoCarroComponentState();
}

class _MenuDonoCarroComponentState extends State<MenuDonoCarroComponent> {
  String? emailUsuario;
  String? nomeUsuario;

  @override
  void initState() {
    super.initState();

    if (AuthService.token != null) {
      var usuario = AuthService.getUsuario();

      emailUsuario = usuario['email'] ?? '';
      nomeUsuario = usuario['nome'] ?? '';
    } else {
      usuarioLogado();
    }
  }

  Future<void> usuarioLogado() async {
    var token = await PrefsService.getToken();

    if (token != null) {
      var decodedToken = JwtDecoder.decode(token);
      if (decodedToken.containsKey('profile')) {
        var userProfile = decodedToken['profile'];
        if (userProfile == 'ROLE_LAVACAR') {
          LavacarService lavaCarService = LavacarService();
          var lavaCar = await lavaCarService.getLavacarByToken();
          nomeUsuario = lavaCar.nome;

          emailUsuario = lavaCar.email;
        } else if (userProfile == 'ROLE_DONOCARRO') {
          DonoCarroService donoCarroService = DonoCarroService();
          var donoCarro = await donoCarroService.getDonoCarroByToken();
          nomeUsuario = donoCarro.nome;
          print(nomeUsuario);
          emailUsuario = donoCarro.email;
        } else {
          Modular.to.pushReplacementNamed(AppRoutes.LOGIN);
        }
      }
    } else {
      Modular.to.pushReplacementNamed(AppRoutes.LOGIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = AuthService.token != null;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 110,
            child: UserAccountsDrawerHeader(
              accountName: Text('${nomeUsuario}'),
              accountEmail: Text('${emailUsuario}'),
            ),
          ),
          CustomDrawerTile(
            title: 'Menu',
            icon: Icons.arrow_forward_ios_sharp,
            onTap: () {
              Modular.to.navigate('/home-donocarro');
            },
          ),
          CustomDrawerTile(
            title: 'Localizar lavacar',
            icon: Icons.arrow_forward_ios_sharp,
            onTap: () {
              Modular.to.navigate('/buscar-lavacar');
            },
          ),
          CustomDrawerTile(
            title: 'Editar perfil',
            icon: Icons.arrow_forward_ios_sharp,
            onTap: () {
              Modular.to.navigate('/dono-carro/');
            },
          ),
          CustomDrawerTile(
            title: 'Veículos',
            icon: Icons.arrow_forward_ios_sharp,
            onTap: () {
              Modular.to.navigate('/lista-veiculos/');
            },
          ),
          CustomDrawerTile(
              title: 'Historico de serviços',
              icon: Icons.arrow_forward_ios_sharp,
              onTap: () {
                Modular.to.navigate('/historico-donocarro');
              }),
          CustomDrawerTile(
            title: 'Sair',
            icon: Icons.exit_to_app,
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () {
              AuthService().logout();
              PrefsService.logout();
              Modular.to.navigate(AppRoutes.LOGIN);
            },
          ),
        ],
      ),
    );
  }
}

class CustomDrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback onTap;

  const CustomDrawerTile({
    required this.title,
    required this.icon,
    this.iconColor,
    this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      trailing: Icon(
        icon,
        color: iconColor,
      ),
      onTap: onTap,
    );
  }
}
