import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lavaja/provider/donocarro_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final DonoCarroProvider donoCarro = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0), child: Text('Home')),
              );
  }
}
