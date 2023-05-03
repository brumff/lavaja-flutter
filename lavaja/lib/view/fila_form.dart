import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Fila extends StatefulWidget {
  @override
  State<Fila> createState() => _FilaState();
}

class _FilaState extends State<Fila> {
  Color _iconColor = Colors.grey;
  bool _showIcon = true;

  void _changeIconColor() {
    setState(() {
      if (_iconColor == Colors.grey) {
        _iconColor = Colors.green;
      } else {
        _showIcon = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fila'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.add)),
              SizedBox(height: 100),
              _showIcon
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.car_crash_outlined,
                            color: _iconColor,
                          ),
                          onPressed: _changeIconColor,
                        ),
                        Text(
                          'Carro fora da APP',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
