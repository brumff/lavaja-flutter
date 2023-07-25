

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  final TextEditingController _addressController = TextEditingController();
  String _latitude = '';
  String _longitude = '';

  void _getCoordinates() async {
    GeoCode geoCode = GeoCode();

    try {
      Coordinates coordinates = await geoCode.forwardGeocoding(
        address: _addressController.text,
      );

      setState(() {
        _latitude = coordinates.latitude.toString();
        _longitude = coordinates.longitude.toString();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo de Geocodificação'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Endereço',
              ),
              onChanged: (_) => _getCoordinates(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _getCoordinates,
              child: Text('Obter Coordenadas'),
            ),
            SizedBox(height: 16.0),
            Text('Latitude: $_latitude'),
            Text('Longitude: $_longitude'),
          ],
        ),
      ),
    );
  }
}