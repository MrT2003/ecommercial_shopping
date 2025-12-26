class AppConfig {
  static const String serverIp = "192.168.1.14";
  static const String port = "8000";

  static const String baseUrl = "http://$serverIp:$port/api";

  static const String authEndpoint = "$baseUrl/auth";
  static const String productEndpoint = "$baseUrl/products";
  static const String cartEndpoint = "$baseUrl/carts";
  static const String userEndpoint = "$baseUrl/users";
  static const String orderEndpoint = "$baseUrl/orders";
  static const String pplEndpoint = "$baseUrl/ppl";
}
