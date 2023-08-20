import 'dart:async';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*void backgroundTask() {
  Timer.periodic(const Duration(seconds: 1), (timer) {
    print('Background task running: ${DateTime.now()}');
  });
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Background Service Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final service = FlutterBackgroundService();
              var isRunning = await service.isRunning();
              
              if (isRunning) {
                service.invoke("stopService");
              } else {
                service.startService();
              }
            },
            child: Text('Toggle Background Service'),
          ),
        ),
      ),
    );
  }
}