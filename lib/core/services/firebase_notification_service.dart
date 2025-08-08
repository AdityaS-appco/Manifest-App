import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Top-level background message handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Ensure Firebase is initialized if needed
  // await Firebase.initializeApp();
  
  log('Background message received: ${message.notification?.title}');
  // You can add additional background message handling logic here
}

class FirebaseNotificationService {
  // Singleton instance
  static final FirebaseNotificationService _instance = FirebaseNotificationService._internal();
  factory FirebaseNotificationService() => _instance;
  FirebaseNotificationService._internal();

  // token [for later purposes]
  String? token;

  // Firebase Messaging instance
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Local Notifications Plugin
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Android Notification Channel
  static const AndroidNotificationChannel _androidNotificationChannel =
      AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  // iOS Notification Settings
  static const DarwinNotificationDetails _iOSNotificationDetails =
      DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // Initialize Notification Service
  Future<void> init() async {
    // Set the background message handler before any other initialization
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _setupLocalNotifications();
    await _configureFirebaseListeners();
    log('Notification Service Initialized');
  }

  // Request Notification Permissions (iOS/Android)
  Future<void> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted notification permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional notification permission');
    } else {
      log('User denied notification permission');
    }
  }

  // Setup Local Notifications Plugin
  Future<void> _setupLocalNotifications() async {
    /// * android initialization settings
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    /// * ios initialization settings
    const initializationSettingsIOS = DarwinInitializationSettings();

    /// * initialization settings
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    /// * initialize local notifications plugin
    await _localNotificationsPlugin.initialize(initializationSettings);

    /// * create android notification channel
    if (Platform.isAndroid) {
      await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_androidNotificationChannel);
    }
  }

  /// * Configure Firebase Listeners for Foreground/Background Notifications
  Future<void> _configureFirebaseListeners() async {
    /// ! Listen for foreground messages [when app is in foreground]
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Foreground message received: ${message.notification?.title}');
      _showLocalNotification(message);
    });

    /// ! Listen for opened messages (when app is in foreground and user taps on notification)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Notification clicked: ${message.notification?.title}');
      // Handle navigation or other actions here
      _showLocalNotification(message);
    });

    /// * Get FCM token for this device
    token = await _messaging.getToken();
    log('FCM Token: $token');

    /// * Listen for token refreshes
    /// * Save or update token on server
    _messaging.onTokenRefresh.listen((newToken) {
      log('FCM Token refreshed: $newToken');
      // Todo: Save or update token on your server here
    });
  }

  /// ! For testing purposes only
  /// * Show Local Notification for Foreground Messages to test
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification != null && Platform.isAndroid) {
      final androidDetails = AndroidNotificationDetails(
        _androidNotificationChannel.id,
        _androidNotificationChannel.name,
        channelDescription: _androidNotificationChannel.description,
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      );

      final details = NotificationDetails(
        android: androidDetails,
        iOS: _iOSNotificationDetails,
      );

      await _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        details,
        payload: jsonEncode(message.data),
      );
    }
  }
}
