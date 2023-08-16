import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeDonoCarro extends StatefulWidget {
  @override
  _HomeDonoCarroState createState() => _HomeDonoCarroState();
}

class _HomeDonoCarroState extends State<HomeDonoCarro> {
  Future<void> _calcularDistancia() async {
    final apiKey = '5b3ce3597851110001cf624865e4cdd0fd3e424fba1da8dfc773a498';
    final profile = 'driving-car';
    final coordinates = [
      [-49.2909128893133, -25.477559267725184], // Origem: São Paulo, SP
      [-49.30063, -25.51999], // Destino: Rio de Janeiro, RJ
    ];

    final dio = Dio();
    dio.options.headers['Authorization'] = '$apiKey';

    try {
      final response = await dio.post(
        'https://api.openrouteservice.org/v2/directions/$profile',
        data: {'coordinates': coordinates},
      );
      if (response.statusCode == 200) {
        final data = response.data;
        final distance = data['routes'][0]['segments'][0]['distance'] /
            1000; 
        final duration = data['routes'][0]['segments'][0]['duration'] /
            60; 

        print('Distância: ${distance.toStringAsFixed(2)} km');
        print('Duração: ${duration.toStringAsFixed(2)} minutos');
      } else {
        print('deu ruim');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distance Calculation Example'),
      ),
      body: ElevatedButton(onPressed: () {
        _calcularDistancia();
      }, child: Text('Obter rota')),
    );
  }
}
