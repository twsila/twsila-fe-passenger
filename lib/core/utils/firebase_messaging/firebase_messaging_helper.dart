import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../helpers/global_key.dart';
import '../resources/strings_manager.dart';
import 'notification_popup.dart';

class FirebaseMessagingHelper extends ChangeNotifier {
  static final _fbm = FirebaseMessaging.instance;
  static final AppPreferences appPreferences = instance<AppPreferences>();

  final player = AudioPlayer();

  Future<void> configure() async {
    _fbm.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    _fbm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      // If the application has been opened from a terminated state via a RemoteMessage (containing a Notification), it will be returned, otherwise it will be null.
      // Once the RemoteMessage has been consumed, it will be removed and further calls to getInitialMessage will be null.

      if (message != null) {
        dynamic notification = message.data;
        print(message);
        FirebaseMessagingHelper.navigateToNotifications(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // if (Get.context == null) return;

      final duration = await player.setAsset(
          'assets/sound/notification-sound.mp3'); // Schemes: (https: | file: | asset: )
      player.play();

      DialogUtils.showNotificationPopup(
          NavigationService.navigatorKey.currentState!.context,
          message.data["title"] ?? "Twsila Notification",
          message.data["body"] ?? "there's a new update!");
      return;
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {});

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await setFcmToken();
  }

  static Future<void> navigateToNotifications(RemoteMessage message) async {}

  static Future<void> setFcmToken() async {
    await _fbm.getToken().then((token) {
      log("FCM token : $token");
      FirebaseMessagingHelper.appPreferences.setFCMToken(token!);
    }).onError((error, stackTrace) {
      print("FCM token error: $error");
    });
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // FirebaseMessagingHelper.notificationCounter.value += 1;
}
