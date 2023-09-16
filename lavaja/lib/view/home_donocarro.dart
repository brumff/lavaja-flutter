import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../components/menu_donocarro_component.dart';
import '../data/auth_service.dart';
import '../data/prefs_service.dart';
import '../routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/auth_service.dart';
import '../data/prefs_service.dart';
import '../routes/app_routes.dart';

class HomeDonoCarro extends StatelessWidget {
  const HomeDonoCarro({Key? key}) : super(key: key);

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
            title: 'Localizar lavacar',
            icon: Icons.local_car_wash,
            onTap: () {
              Modular.to.navigate('/buscar-lavacar');
            },
          ),
          CustomDrawerCard(
            title: 'Perfil',
            icon: Icons.account_circle_outlined,
            onTap: () {
             Modular.to.navigate('/dono-carro/');
            },
          ),
          CustomDrawerCard(
            title: 'Veículos',
            icon: Icons.directions_car_rounded,
            onTap: () {
              Modular.to.navigate('/lista-veiculos/');
            },
          ),
          CustomDrawerCard(
            title: 'Historico de serviços',
            icon: Icons.history,
            onTap: () {
             
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
      drawer:  MenuDonoCarroComponent(),
    );
  }
}

class CustomDrawerCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback onTap;

  const CustomDrawerCard({
    required this.title,
    required this.icon,
    this.iconColor,
    this.textColor,
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



