import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
    if (message == null) return;
  }

  Future initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
  
// Método para enviar notificação para um único dispositivo com base no token
  Future<void> sendNotificationToUser(String fcmToken, String title, String body) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: {
          'to': fcmToken,
          'notification': {
            'title': title,
            'body': body,
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          },
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'key=YOUR_FIREBASE_SERVER_KEY',
          },
        ),
      );

      print('Notification sent: ${response.statusCode}');
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

}
