import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeLavaCar extends StatefulWidget {
  @override
  State<HomeLavaCar> createState() => _HomeLavaCarState();
}

class _HomeLavaCarState extends State<HomeLavaCar> {
  bool _value = false;
  Color _switchColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Lava Car'),
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
                    'Deseja abrir lava car?',
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
                        } else {
                          _switchColor = Colors.red;
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
    );
  }
}
