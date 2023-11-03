

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lavaja/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;


  Future<void> iniNotification() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();

    print('TOKEN ' + fCMToken.toString());

    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    print("dkfjkdfjkdfjdfdfd :::::::::::::::::::::::::::");
    if (message == null) return;
  }

  Future initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage();
    print("dkfjkdfjkdfjdfdfd :::::::::::::::::::::::::::");
    FirebaseMessaging.onMessage.listen((handleMessage) {
      RemoteNotification notification = handleMessage.notification!;
      AndroidNotification androidNotification =
          handleMessage.notification!.android!;
      if (notification != null && androidNotification != null) {
          if (notification != null && androidNotification != null) {


        sendNotification(title: notification.title!, mensagem: notification.body);

      }
      }
    });
  }
  


}
