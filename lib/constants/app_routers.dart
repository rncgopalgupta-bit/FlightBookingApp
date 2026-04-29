// ignore_for_file: prefer_const_constructors

import 'package:flightbookingapp/screen_view/home/flight_detail_screen.dart';
import 'package:flightbookingapp/screen_view/home/flight_result_screen.dart';
import 'package:flightbookingapp/screen_view/home/home_screen.dart';
import 'package:flightbookingapp/screen_view/login&singup/splashscreen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String flightResult = '/flightResult';
  static const String flightDetail = '/flightDetail';

  static List<GetPage> pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: flightResult, page: () => const FlightResultScreen()),
    GetPage(name: flightDetail, page: () => const FlightDetailScreen()),
  ];
}
