import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lavaja/provider/lavacar_provider.dart';
import 'package:provider/provider.dart';

import '../components/menu_donocarro_component.dart';
import '../controller/teste_controller.dart';
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
  int maxTempoEspera = 0;
  bool distanciasCalculadas = false;
  bool buscaEnd = false;
  final _maxTempoEsperaController = TextEditingController();
  double maxDistance = 0;
  final _maxDistanceController = TextEditingController();
  final LocalizacaoController _localizacaoController =
      Modular.get<LocalizacaoController>();

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

  void _applyFilters(
      int _maxTempoEsperaController, double _maxDistanceController) {
    setState(() {
      filteredLavacarList = lavacarList
          .where((lavacar) =>
              lavacar.tempoFila != null &&
              lavacar.tempoFila! <= _maxTempoEsperaController ||
              lavacar.distanceInKm != null &&
              lavacar.distanceInKm! <= _maxDistanceController)
          .toList();
    });
    print(filteredLavacarList);
  }

  Future<void> _verificarLocalizacao() async {
    await _localizacaoController.getPosicao();

    if (_localizacaoController.erro.isEmpty) {
      setState(() {
        latitude = _localizacaoController.lat;
        print(latitude);
        longitude = _localizacaoController.long;
        print(longitude);
        buscaEnd = true;
      });

      await _listarLavacars();
      await _calcularDistancia();
      
    } else {
      setState(() {
        buscaEnd = false;
      });
    }
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
            buscaEnd = true;
          });
        } else {
          print(
              'Nenhum resultado encontrado para o endereço $endereco no Brasil.');
          buscaEnd = false;
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
          final distanceInKm =
              double.parse((distanceInMeters / 1000).toStringAsFixed(2));
          location.distanceInKm = distanceInKm;
          print(distanceInKm);

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

    if (buscaEnd == true) {
      await _listarLavacars();
      _calcularDistancia();
      setState(() {
        isLoading = false;
      });
      _maxTempoEsperaController.text = maxTempoEspera.toString();
    }
  }

  void _limparLista() {
    setState(() {
      distancias.clear();
      buscaEnd = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _verificarLocalizacao();
    _maxTempoEsperaController.text = maxTempoEspera.toString();
    _maxTempoEsperaController.text =
        maxTempoEspera == 1000 ? '' : maxTempoEspera.toString();
  }

  @override
  void dispose() {
    _maxTempoEsperaController.dispose();
    super.dispose();
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
          SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          height: 250,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: TextField(
                                  decoration: InputDecoration(
                                      label: Text('Tempo de espera máx.')),
                                  controller: _maxTempoEsperaController,
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      maxTempoEspera = 1000;
                                    } else {
                                      try {
                                        setState(() {
                                          maxTempoEspera = int.parse(value);
                                        });
                                      } catch (e) {
                                        print('Erro de conversão');
                                      }
                                    }
                                  },
                                ),
                              ),
                              StatefulBuilder(
                                builder: (context, state) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Alinhar à esquerda
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 2, 20, 2),
                                        child: Text(
                                          'Filtro de Distância:',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Slider(
                                          value: maxDistance,
                                          max: 50,
                                          divisions: 10,
                                          label: maxDistance.round().toString(),
                                          onChanged: (double value) {
                                            state(() {});
                                            setState(() {
                                              maxDistance = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
                                  child: TextButton(
                                      onPressed: () {
                                        _applyFilters(
                                            maxTempoEspera, maxDistance);
                                        FocusScope.of(context).unfocus();
                                        Navigator.pop(context);
                                      },
                                      child: Text('Aplicar filtros')))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text('Filtros'),
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.blue),
              )),
          Expanded(
              child: buscaEnd
                  ? distancias.length == 0
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: filteredLavacarList.length,
                          itemBuilder: (context, index) {
                            final lavacar = filteredLavacarList[index];
                            final distancia = distancias[index];
                            final parts = distancia.split(':');
                            final nome = parts[0];
                            final distanciaText = parts[1];
                            final tempoEspera = lavacar.tempoFila;
                            int tempoFormatado = tempoEspera?.toInt() ?? 0;

                            return GestureDetector(
                              onTap: () {
                                Modular.to.pushNamed('/detalhes-lavacar/${lavacar.id}');
                              },
                              child: ListTile(
                                title: Text(nome),
                                subtitle: Text(
                                  'Distância: $distanciaText km - Tempo de Espera: ${tempoFormatado ?? "N/A"} minutos',
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            );
                          },
                        )
                  : Center(
                      child: Text('Nenhum registro'),
                    )),
        ],
      ),
      drawer: MenuDonoCarroComponent(),
    );
  }
}
