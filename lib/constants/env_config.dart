enum Environment { dev, staging, prod }

class EnvConfig {
  // Change this to switch environments
  static Environment currentEnvironment = Environment.dev;

  static String get baseUrl {
    switch (currentEnvironment) {
      case Environment.dev:
        return "https://flight.wigian.in/flight_api.php/";
      case Environment.staging:
        return "https://flight.wigian.in/flight_api.php/";
      case Environment.prod:
        return "https://flight.wigian.in/flight_api.php/";
    }
  }
}
