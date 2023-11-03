import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> sendNotification(
    {String? token, String? title, String? mensagem}) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Inicialize as configurações para diferentes plataformas
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(
    defaultActionName: 'hello',
  );
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      linux: initializationSettingsLinux);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  // Configurar o canal de notificação Android
const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('high_channel', 'High Importance Notification',
          channelDescription: 'This channel is for important notification',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker', // Texto que aparece na barra de status
          styleInformation: BigTextStyleInformation(''), // Permite texto longo
          icon: 'ic_stat_onesignal_default'); 

  // Construir a notificação
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Enviar a notificação
  await flutterLocalNotificationsPlugin.show(
    0, // ID da notificação
    title,
    mensagem,
    platformChannelSpecifics,
  );
}
