import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../data/auth_service.dart';
import '../data/prefs_service.dart';
import '../routes/app_routes.dart';

class CardHomeDonoCarro extends StatelessWidget {
  const CardHomeDonoCarro({Key? key}) : super(key: key);

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
          GridView.count(
            crossAxisCount: 2, // Define 2 cards por linha
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              CustomDrawerCard(
                title: 'Editar perfil',
                icon: Icons.arrow_forward_ios_sharp,
                onTap: () {
                  Modular.to.navigate('/dono-carro/');
                },
              ),
              CustomDrawerCard(
                title: 'Veículos',
                icon: Icons.arrow_forward_ios_sharp,
                onTap: () {
                  Modular.to.navigate('/lista-veiculos/');
                },
              ),
              CustomDrawerCard(
                title: 'Historico de serviços',
                icon: Icons.arrow_forward_ios_sharp,
                onTap: () {},
              ),
              CustomDrawerCard(
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
        ],
      ),
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
