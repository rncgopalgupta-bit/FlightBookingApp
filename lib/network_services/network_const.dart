import '../constants/env_config.dart';

class NetworkConsts {
  // Blogger API v3 base URL
  static String get baseUrl => EnvConfig.baseUrl;

  //endpoints
  static String get from => "airports/from";
  static String get to => "airports/to";
  static String get search => "search";
  static String get flight => "flight";
  static String get airlines => "airlines";
  static String get aircraftTypes => "aircraft-types";
}
