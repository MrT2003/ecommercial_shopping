class UserAuth {
  final String userId;
  final String name;
  final String email;
  final String password;
  final String? phone;
  final String? address;
  final String role;
  final List<dynamic> orders;
  final String? accessToken; // Thêm accessToken

  UserAuth({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    this.phone,
    this.address,
    required this.role,
    required this.orders,
    this.accessToken, // Thêm accessToken vào constructor
  });

  factory UserAuth.fromResponseJson(Map<String, dynamic> json) {
    final user = json['user'];
    return UserAuth(
      userId: user['_id'],
      name: user['name'],
      email: user['email'],
      password: user['password'],
      phone: user['phone'],
      address: user['address'],
      role: user['role'],
      orders: user['orders'] ?? [],
      accessToken: json['access_token'], // Lưu access_token
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": userId,
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "address": address,
      "role": role,
      "orders": orders,
      "access_token": accessToken, // Đảm bảo lưu token khi cần
    };
  }
}
