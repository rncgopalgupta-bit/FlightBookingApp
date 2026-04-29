// ignore_for_file: prefer_const_constructors

import 'package:flightbookingapp/constants/app_routers.dart';
import 'package:flightbookingapp/screen_view/login&singup/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flightbookingapp/providers/flight_detail_provider.dart';
import 'package:flightbookingapp/providers/flight_result_provider.dart';
import 'package:flightbookingapp/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:flightbookingapp/constants/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EnvConfig.currentEnvironment = Environment.dev;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => FlightResultProvider()),
        ChangeNotifierProvider(create: (_) => FlightDetailProvider()),
      ],
      child: GetMaterialApp(
        title: 'BookingApp',
        debugShowCheckedModeBanner: false,
        getPages: AppRoutes.pages,
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1D2A3E)),
          useMaterial3: true,
          fontFamily: 'Montserrat',
        ),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.noScaling),
            child: SafeArea(
              top: false,
              bottom: true,
              left: false,
              right: false,
              child: child ?? const SizedBox.shrink(),
            ),
          );
        },
        home: const SplashScreen(),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
