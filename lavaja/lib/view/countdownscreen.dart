import 'dart:async';
import 'package:flutter/material.dart';

class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  int countdownValue = 10; // Valor inicial da contagem regressiva
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countdownValue--;
        if (countdownValue < -10) {
          timer.cancel();
        }
      });
    });
  }

  void restartCountdown() {
    setState(() {
      countdownValue = 10;
    });
    startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contagem Regressiva'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contagem: $countdownValue',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: countdownValue < -10 ? null : restartCountdown,
              child: Text('Reiniciar Contagem'),
            ),
          ],
        ),
      ),
    );
  }
}
