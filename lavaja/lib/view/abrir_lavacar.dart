import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:provider/provider.dart';

import '../components/menu_lavacar_component.dart';
import '../routes/app_routes.dart';

class AbrirLavaCar extends StatefulWidget {
  @override
  State<AbrirLavaCar> createState() => _AbrirLavaCarState();
}

class _AbrirLavaCarState extends State<AbrirLavaCar> {
  bool _value = false;
  Color _switchColor = Colors.red;
  String textoLavacar = "Fechar Lava Car"; // Defina o valor padrão para "fechado"

  @override
  void initState() {
    super.initState();
    Provider.of<LavacarProvider>(context, listen: false).getLavacar().then((_) {
      bool usuarioAberto = Provider.of<LavacarProvider>(context, listen: false)
              .usuario
              ?.aberto ??
          false;
      setState(() {
        _value = usuarioAberto;
        _switchColor = usuarioAberto ? Colors.green : Colors.red;
        textoLavacar = usuarioAberto ? "Deseja fechar lava-car" : "Deseja abrir lava-car";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(textoLavacar), // Use a variável textoLavacar aqui
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    textoLavacar, // Use a variável textoLavacar aqui também
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Switch(
                    value: _value,
                    onChanged: (bool newValue) {
                      setState(() {
                        _value = newValue;
                        if (_value) {
                          _switchColor = Colors.green;
                          Provider.of<LavacarProvider>(context, listen: false)
                              .abrirLavacar(true);
                          textoLavacar = "Fechar Lava Car";
                          Modular.to.navigate(AppRoutes.CREATEFILA);
                        } else {
                          _switchColor = Colors.red;
                          Provider.of<LavacarProvider>(context, listen: false)
                              .abrirLavacar(false);
                          textoLavacar = "Abrir Lava Car";
                        }
                      });
                    },
                    activeColor: _switchColor,
                    inactiveThumbColor: _switchColor,
                    inactiveTrackColor: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: MenuLavacarComponent(),
    );
  }
}