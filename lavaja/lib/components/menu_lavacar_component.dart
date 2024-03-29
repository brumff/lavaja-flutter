import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/data/auth_service.dart';
import 'package:lavaja/data/prefs_service.dart';
import 'package:lavaja/models/lavacar.dart';

import '../routes/app_routes.dart';

class MenuLavacarComponent extends StatefulWidget {
  const MenuLavacarComponent({Key? key}) : super(key: key);

  @override
  State<MenuLavacarComponent> createState() => _MenuLavacarComponentState();
}

class _MenuLavacarComponentState extends State<MenuLavacarComponent> {
  String? emailUsuario;
  String? nomeUsuario;

  @override
  void initState() {
    super.initState();

    if (AuthService.token != null) {
      var usuario = AuthService.getUsuario();

      emailUsuario = usuario['email'] ?? '';
      nomeUsuario = usuario['nome'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 110,
            child: UserAccountsDrawerHeader(accountName: Text('${nomeUsuario}'), accountEmail:  Text('${emailUsuario}')),
            color: Colors.blue,
          ),
          CustomDrawerTile(
            title: 'Menu',
            icon: Icons.arrow_forward_ios_sharp,
            onTap: () {
              Modular.to.navigate('/home-lavacar');
            },
          ),
          CustomDrawerTile(
            title: 'Editar perfil',
            icon: Icons.arrow_forward_ios_sharp,
            onTap: () {
              Modular.to.navigate('/lava-car/');
            },
          ),
          CustomDrawerTile(
            title: 'Fila',
            icon: Icons.arrow_forward_ios_sharp,
            onTap: () {
              Modular.to.navigate('/contratarservico');
            },
          ),
          CustomDrawerTile(
            title: 'Serviços',
            icon: Icons.arrow_forward_ios_sharp,
            onTap: () {
              Modular.to.navigate('/servico');
            },
          ),
          CustomDrawerTile(
              title: 'Historico de serviços',
              icon: Icons.arrow_forward_ios_sharp,
              onTap: () {
                Modular.to.navigate('/historico-lavacar');
              }),
          CustomDrawerTile(
              title: 'Disponibilidade lavacar',
              icon: Icons.arrow_forward_ios_sharp,
              onTap: () {
                Modular.to.navigate('/abrir-lavacar');
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
