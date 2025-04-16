import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:taxi_for_you/core/utils/resources/langauge_manager.dart';

import 'app/app.dart';
import 'app/di.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  await Firebase.initializeApp();
  const systemBarColors = SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    systemNavigationBarColor: Colors.black,
    statusBarIconBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(systemBarColors);
  runApp(EasyLocalization(
      supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
      path: ASSET_PATH_LOCALISATIONS,
      child: Phoenix(child: MyApp())));
}