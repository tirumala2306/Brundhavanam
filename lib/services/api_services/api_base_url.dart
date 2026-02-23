enum Environment { dev, staging, production }

class ApiBaseUrl {
  // static Environment _environment = Environment.dev;

  // static void setEnvironment(Environment env) {
  //   _environment = env;
  // }

  // static String get baseUrl {
  //   switch (_environment) {
  //     case Environment.dev:
  //       return "https://dev.api.com/";
  //     case Environment.staging:
  //       return "https://staging.api.com/";
  //     case Environment.production:
  //       return "https://api.com/";
  //   }
  // }

  static String get baseUrl {
    return "http://192.168.88.14:8080/brundhavanam";
  }
}
