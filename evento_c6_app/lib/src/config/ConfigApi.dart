class ConfigApi {
  static const String appName = "Colegio";
  // static const String apiURL = "172.22.4.12:9090";
  static const String apiURL = "192.168.0.105:9090";
  static const String loginAPI = "/auth/login";
  static const String registerAPI = "/auth/create";
  static const String listUserAPI = "/auth/list";

  static String buildUrl(String endpoint) {
    return 'http://$apiURL$endpoint';
  }

}

