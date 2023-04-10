import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_firebase/google_firebase.dart';
import 'package:logger/logger.dart';
import 'package:platform_interface/package_platform.dart';
import 'package:runner/runner.dart';

class GoogleFirebase implements PackagePlatform {
  final GoogleFirebaseOptions? options;

  GoogleFirebase({this.options});

  @override
  Future<void> register(GetIt locator) async {
    // 3rd-party registration
    locator
      ..registerSingleton<FirebaseApp>(
        await Firebase.initializeApp(options: options?.firebaseOptions),
      )
      ..registerSingleton<FirebaseAppCheck>(
        FirebaseAppCheck.instance
          ..activate(
            androidProvider: AndroidProvider.playIntegrity,
            webRecaptchaSiteKey: 'recaptcha-v3-site-key',
          ),
      )
      ..registerSingleton<FirebaseAuth>(FirebaseAuth.instance)
      ..registerSingleton<GoogleSignIn>(GoogleSignIn())
      ..registerSingleton<FirebaseDatabase>(FirebaseDatabase.instance)
      ..registerSingleton<FirebaseRemoteConfig>(FirebaseRemoteConfig.instance)
      ..registerSingleton<FirebaseAnalytics>(FirebaseAnalytics.instance)
      ..registerSingleton<FirebaseCrashlytics>(FirebaseCrashlytics.instance)
      ..registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance)
      ..registerSingleton<FirebaseStorage>(FirebaseStorage.instance)
      ..registerSingleton<FirebaseMessaging>(FirebaseMessaging.instance)
      ..registerSingleton<FlutterLocalNotificationsPlugin>(
          FlutterLocalNotificationsPlugin());
  }

  @override
  Future<void> onRegistered(GetIt locator) async {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = locator<FirebaseCrashlytics>().recordFlutterError;
    PlatformDispatcher.instance.onError = (exception, stackTrace) {
      locator<FirebaseCrashlytics>().recordError(
        exception,
        stackTrace,
        fatal: true,
      );
      return true;
    };

    // Post registration
    locator<FirebaseDatabase>().setPersistenceEnabled(true);
    locator<FirebaseFirestore>().settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );

    // Remote config initialization
    locator<FirebaseRemoteConfig>()
      ..setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      )
      ..fetchAndActivate();

    try {
      // Using zero duration to force fetching from remote server.
      await locator<FirebaseRemoteConfig>().setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
      await locator<FirebaseRemoteConfig>().fetchAndActivate();
    } on PlatformException catch (exception) {
      // Fetch exception.
      Logger().e('PlatformException', exception);
    }

    _firebaseMessagingRegistrar();

    await _usecasesRegistrar(locator);
  }

  Future<void> _firebaseMessagingRegistrar() async {
    final messaging = options?.messaging;
    if (messaging != null) {
      // Local Notification Setup
      locator<FlutterLocalNotificationsPlugin>()
        ..resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestPermission()
        ..initialize(
          messaging.localNotificationSettings,
          onDidReceiveNotificationResponse:
              messaging.onDidReceiveNotificationResponse,
        );

      // Firebase Messaging
      final settings = await locator<FirebaseMessaging>().requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      locator.registerSingleton<NotificationSettings>(settings);

      Logger().d('User granted permission: ${settings.authorizationStatus}');

      locator<FirebaseMessaging>()
        // iOS Configuration
        ..setForegroundNotificationPresentationOptions(
          alert: true, // Required to display a heads up notification
          badge: true,
          sound: true,
        )
        ..getToken().then((value) => Logger().d('FCM Token: $value'));

      FirebaseMessaging.onMessage.listen((event) => messaging
          .onForegroundMessageReceived
          ?.call(event, locator<FlutterLocalNotificationsPlugin>(), locator));

      final onBackgroundMessageReceived = messaging.onBackgroundMessageReceived;

      if (onBackgroundMessageReceived != null) {
        FirebaseMessaging.onBackgroundMessage(onBackgroundMessageReceived);
      }
    }
  }

  Future<void> _usecasesRegistrar(GetIt locator) async {
    final usecases = [
      // Firebase Auth
      GetFirebaseProfileUsecase(locator),

      // Remote Config
      GetRemoteConfigUsecase(locator),
    ];

    await Future.wait(usecases.map((e) => e.register(locator)));
  }
}
