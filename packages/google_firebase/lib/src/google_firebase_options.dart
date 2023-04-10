import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

class GoogleFirebaseOptions {
  final FirebaseOptions? firebaseOptions;
  final FirebaseMessagingOptions? messaging;

  GoogleFirebaseOptions({this.firebaseOptions, this.messaging});
}

class FirebaseMessagingOptions {
  final InitializationSettings localNotificationSettings;
  final void Function(NotificationResponse response)?
      onDidReceiveNotificationResponse;
  final void Function(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin localNotificationPlugin,
    GetIt locator,
  )? onForegroundMessageReceived;
  final Future<void> Function(RemoteMessage message)?
      onBackgroundMessageReceived;

  FirebaseMessagingOptions({
    required this.localNotificationSettings,
    this.onDidReceiveNotificationResponse,
    this.onForegroundMessageReceived,
    this.onBackgroundMessageReceived,
  });
}
