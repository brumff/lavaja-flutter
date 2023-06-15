import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../routes/app_routes.dart';

class MenuLavacarComponent extends StatelessWidget {
  const MenuLavacarComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 75,
            color: Colors.blue,
          ),
          CustomDrawerTile(
            title: 'Editar perfil',
            icon: Icons.arrow_forward_ios_sharp,
            onTap: () {
              Modular.to.navigate('/lava-car/');
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
            title: 'Alterar senha',
            icon: Icons.arrow_forward_ios_sharp,
            onTap: () {},
          ),
          CustomDrawerTile(
              title: 'Historico de serviços',
              icon: Icons.arrow_forward_ios_sharp,
              onTap: () {
                 Modular.to.navigate('/historico-lavacar');
              }),
          CustomDrawerTile(
              title: 'Fechar lavacar',
              icon: Icons.arrow_forward_ios_sharp,
              onTap: () {}),
          CustomDrawerTile(
            title: 'Sair',
            icon: Icons.exit_to_app,
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () {
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
