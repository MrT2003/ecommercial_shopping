class UserAuth {
  final String userId;
  final String name;
  final String email;
  final String password;
  final String? phone;
  final String? address;
  final String role;
  final List<dynamic> orders; // Danh sách đơn hàng (để trống ban đầu)

  UserAuth({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    this.phone,
    this.address,
    required this.role,
    required this.orders,
  });

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      userId: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      address: json['address'],
      role: json['role'],
      orders: json['orders'] ?? [],
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
    };
  }
}
