import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

import '../helpers/global_key.dart';
import '../local_notification/local_notification_helper.dart';
import '../resources/strings_manager.dart';

class FirebaseMessagingHelper extends ChangeNotifier {
  static final _fbm = FirebaseMessaging.instance;
  static final AppPreferences appPreferences = instance<AppPreferences>();

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(AppStrings.cancel.tr()),
    onPressed: () {
      Navigator.pop(NavigationService.navigatorKey.currentState!.context);
    },
  );
  Widget continueButton = TextButton(
    child: Text(AppStrings.ok.tr()),
    onPressed: () {
      Navigator.pop(NavigationService.navigatorKey.currentState!.context);
    },
  );

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
      // if (message.notification != null &&
      //     NavigationService.navigatorKey.currentContext != null) {
      //   showDialog(
      //       context: NavigationService.navigatorKey.currentState!.context,
      //       builder: (_) => AlertDialog(
      //             title: Text(message.notification!.title ?? ""),
      //             content: Text(message.notification!.body ?? ""),
      //             actions: [continueButton],
      //           ));
      // } else if (message.data["title"] != null &&
      //     message.data["title"] != "" &&
      //     NavigationService.navigatorKey.currentContext != null) {
      //   showDialog(
      //       context: NavigationService.navigatorKey.currentState!.context,
      //       builder: (_) => AlertDialog(
      //             title: Text(message.data["title"] ?? ""),
      //             content: Text(message.data["body"] ?? ""),
      //             actions: [continueButton],
      //           ));
      // }

      // Fire a local notification
      await NotificationHelper.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: message.data["title"] ?? 'Tawsila Notification',
        body: message.data["body"] ?? 'New Update',
      );
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
