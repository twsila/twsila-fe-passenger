import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/app/bloc_providers.dart';
import 'package:taxi_for_you/app/global_variables.dart';
import '../core/utils/resources/routes_manager.dart';
import '../core/utils/resources/theme_manager.dart';
import 'app_prefs.dart';
import 'di.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  // named constructor
  MyApp._internal();

  int appState = 0;

  static final MyApp _instance =
      MyApp._internal(); // singleton or single instance

  factory MyApp() => _instance; // factory

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: blocProviders(context),
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [GlobalVariable.routeObserver],
        navigatorKey: GlobalVariable.navigatorKey,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        theme: getApplicationTheme(),
      ),
    );
  }
}
