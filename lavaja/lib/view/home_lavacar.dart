import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/components/menu_lavacar_component.dart';

import '../data/auth_service.dart';
import '../data/prefs_service.dart';
import '../routes/app_routes.dart';

class HomeLavacar extends StatelessWidget {
  const HomeLavacar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MENU'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          CustomDrawerCard(
            title: 'Disponibilidade lavacar',
            icon: Icons.toggle_on,
            onTap: () {
              Modular.to.navigate('/abrir-lavacar');
            },
          ),
          CustomDrawerCard(
            title: 'Fila de veículos',
            icon: Icons.local_car_wash,
            onTap: () {
              Modular.to.navigate('/contratarservico');
            },
          ),
          CustomDrawerCard(
            title: 'Perfil',
            icon: Icons.account_circle_outlined,
            onTap: () {
              Modular.to.navigate('/lava-car/');
            },
          ),
          CustomDrawerCard(
            title: 'Serviços',
            icon: Icons.format_list_numbered,
            onTap: () {
              Modular.to.navigate('/servico');
            },
          ),
          CustomDrawerCard(
            title: 'Historico de serviços',
            icon: Icons.history,
            onTap: () {
              Modular.to.navigate('/historico-lavacar');
            },
          ),
          CustomDrawerCard(
            title: 'Sair',
            icon: Icons.logout,
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
      drawer: MenuLavacarComponent(),
    );
  }
}

class CustomDrawerCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final Color? textColor;
  final double iconSize;
  final VoidCallback onTap;

  const CustomDrawerCard({
    required this.title,
    required this.icon,
    this.iconColor,
    this.textColor,
    this.iconSize = 55.0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: iconSize, // Use o tamanho do ícone definido
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
