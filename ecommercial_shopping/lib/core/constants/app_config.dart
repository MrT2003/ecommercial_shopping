class AppConfig {
  // --- CHỈ CẦN SỬA IP Ở DÒNG NÀY LÀ XONG ---
  static const String serverIp = "192.168.1.17";
  static const String port = "8000";

  // Base URL gốc
  static const String baseUrl = "http://$serverIp:$port/api";

  // Các Endpoint con (tự động ăn theo baseUrl)
  static const String authEndpoint = "$baseUrl/auth";
  static const String productEndpoint = "$baseUrl/products";
  static const String cartEndpoint = "$baseUrl/carts";
  static const String userEndpoint = "$baseUrl/users";
  static const String orderEndpoint = "$baseUrl/orders";
  static const String pplEndpoint = "$baseUrl/ppl";
}
