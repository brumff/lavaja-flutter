import 'package:flutter/material.dart';

class ContratarServDonocarro extends StatefulWidget {
  @override
  State<ContratarServDonocarro> createState() => _ContratarServDonocarroState();
}

class _ContratarServDonocarroState extends State<ContratarServDonocarro> {
  String selectedVehicle = 'Carro';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo do pedido'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.location_on_sharp,
                  ),
                  title: Text(
                    'Informações Lavacar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('Dados'),
                ),
              ],
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.timer,
                  ),
                  title: Text(
                    'Tempo de espera',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('15 Min.'),
                ),
              ],
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.local_car_wash_sharp,
                  ),
                  title: Text(
                    'Serviço',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('Serviço selecionado'),
                ),
              ],
            ),
            Column(
              children: [
                ListTile(
                    leading: Icon(
                      Icons.directions_car_filled_sharp,
                    ),
                    title: Text(
                      'Veículo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: DropdownButton(
                      value: selectedVehicle,
                       underline: Container(),
                      items: ['Carro', 'Moto', 'Bicicleta']
                          .map(
                        (String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (newValue) {
                        if (['Carro', 'Moto', 'Bicicleta'].contains(newValue)) {
                          setState(() {
                            selectedVehicle = newValue!;
                          });
                        }
                      },
                    )),
              ],
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.paid,
                  ),
                  title: Text(
                    'Valor total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('R\$ 100'),
                ),
              ],
            ),
            ElevatedButton(onPressed: () {}, child: Text('CONFIRMAR'))
          ],
        ),
      ),
    );
  }
}
