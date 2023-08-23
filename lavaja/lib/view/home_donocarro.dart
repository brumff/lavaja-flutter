import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:provider/provider.dart';

import '../components/menu_donocarro_component.dart';
import '../data/servico_service.dart';
import '../models/lavacar.dart';
import '../provider/contratarservico_provider.dart';
import '../provider/home_donocarro_provider.dart';

class HomeDonoCarro extends StatefulWidget {
  @override
  _HomeDonoCarroState createState() => _HomeDonoCarroState();
}

class _HomeDonoCarroState extends State<HomeDonoCarro> {
  List<Lavacar> lavacarList = [];
  bool listLoaded = false;
  final Dio dio = Dio();
  String endereco = "";
  double latitude = 0.0;
  double longitude = 0.0;
  List<String> distancias = [];
  bool isLoading = false;
  List<Lavacar> filteredLavacarList = [];
  double maxDistancia = 0.0;
  int maxTempoEspera = 0;
  bool distanciasCalculadas = false;

  Future<void> _listarLavacars() async {
    await Provider.of<LavacarProvider>(context, listen: false).loadLavacar();
    setState(() {
      lavacarList =
          Provider.of<LavacarProvider>(context, listen: false).lavacar;
      listLoaded = true;
      filteredLavacarList = List.from(lavacarList);
    });
    print('Lista de Lavacars:');
    lavacarList.forEach((item) {
      print(
          'Nome: ${item.nome ?? 'N/A'}, Tempo: ${item.tempoFila ?? 0} Latitude: ${item.latitude.toString()}, Longitude: ${item.longitude.toString()}');
    });
  }

  void _applyFilters(double maxDistanciaValue, int maxTempoEsperaValue) {
    setState(() {
      filteredLavacarList = lavacarList
          .where((lavacar) => lavacar.tempoFila! <= maxTempoEsperaValue)
          .toList();
    });
  }

  Future<void> _buscarLatLong() async {
    final apiKey = '5b3ce3597851110001cf624865e4cdd0fd3e424fba1da8dfc773a498';

    try {
      final response = await dio.get(
        'https://api.openrouteservice.org/geocode/search',
        queryParameters: {
          'api_key': apiKey,
          'text': endereco,
          'boundary.country': 'BRA',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['features'];
        if (data.isNotEmpty) {
          final geometry = data[0]['geometry'];
          setState(() {
            latitude = geometry['coordinates'][1];
            longitude = geometry['coordinates'][0];
          });
        } else {
          print(
              'Nenhum resultado encontrado para o endereço $endereco no Brasil.');
        }
      } else {
        print('Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao fazer a requisição: $e');
    }
  }

  Future<void> _calcularDistancia() async {
    final apiKey = '5b3ce3597851110001cf624865e4cdd0fd3e424fba1da8dfc773a498';
    final profile = 'driving-car';
    List<String> calculatedDistancias = [];

    for (var location in lavacarList) {
      final endLat = location.latitude;
      final endLon = location.longitude;

      final apiUrl =
          "https://api.openrouteservice.org/v2/directions/$profile?api_key=$apiKey&start=$longitude,$latitude&end=$endLon,$endLat";
      try {
        final response = await dio.get(apiUrl);
        if (response.statusCode == 200) {
          final data = response.data;
          final distanceInMeters =
              data['features'][0]['properties']['segments'][0]['distance'];
          final distanceInKm = (distanceInMeters / 1000).toStringAsFixed(2);
          calculatedDistancias.add('${location.nome}: $distanceInKm km');
        } else {
          print('Erro na requisição: ${response.statusCode}');
        }
      } catch (e) {
        print('Erro ao fazer a requisição: $e');
      }
    }
    setState(() {
      distancias = calculatedDistancias;
      distanciasCalculadas = true;
    });
  }

  Future<void> _handleButtonPress() async {
    setState(() {
      isLoading = true;
      _limparLista();
    });
    await _buscarLatLong();
    await _listarLavacars();
    _calcularDistancia();
    setState(() {
      isLoading = false;
    });
  }

  void _limparLista() {
    setState(() {
      distancias.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  endereco = value;
                });
              },
              decoration: InputDecoration(
                  label: Text('Digite o endereço'),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _handleButtonPress();
                      },
                      icon: Icon(Icons.search))),
            ),
          ),
          SizedBox(height: 10), // Add spacing between the fields
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.timer_outlined),
                SizedBox(width: 12),
                /* Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      label: Text('De'),
                    ),
                  ),
                ),*/
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Até'),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        maxTempoEspera  = 100;
                      }
                      setState(() {
                        maxTempoEspera = int.parse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextButton(
                onPressed: () {
                  _applyFilters(maxDistancia, maxTempoEspera);
                },
                child: Text('Aplicar filtro'),
                style: TextButton.styleFrom(
                    primary: Colors.white, // Cor do texto do botão
                    backgroundColor: Colors.blue),
              )),
          Expanded(
            child: distanciasCalculadas
                ? isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ListView.builder(
                      
                        itemCount: filteredLavacarList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            isLoading = false;
                          }
                          final lavacar = filteredLavacarList[index];
                          final distancia = distancias[index];
                          final parts = distancia.split(':');
                          final nome = parts[0];
                          final distanciaText = parts[1];
                          final tempoEspera = lavacar.tempoFila;
                          int tempoFormatado = tempoEspera?.toInt() ?? 0;

                          return ListTile(
                            title: Text(nome),
                            subtitle: Text(
                              'Distância: $distanciaText km - Tempo de Espera: ${tempoFormatado ?? "N/A"} minutos',
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_sharp),
                          );
                        },
                      )
                : SizedBox.shrink(),
          ),
        ],
      ),
      drawer: MenuDonoCarroComponent(),
    );
  }
}
