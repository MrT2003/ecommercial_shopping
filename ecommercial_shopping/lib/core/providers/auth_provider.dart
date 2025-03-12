import 'package:ecommercial_shopping/core/models/auth.dart';
import 'package:ecommercial_shopping/core/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider((ref) => AuthService());

final authStateProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<UserAuth?>>(
  (ref) => AuthNotifier(ref.read(authServiceProvider)),
);

class AuthNotifier extends StateNotifier<AsyncValue<UserAuth?>> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AsyncValue.data(null));

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? address,
  }) async {
    state = const AsyncValue.loading();
    try {
      final user = await _authService.signup(
        name: name,
        email: email,
        password: password,
        phone: phone, // Không cần kiểm tra null ở đây
        address: address,
      );

      print("Signup successful, user: ${user.toJson()}"); // Debug

      // Không cần check user.id.isNotEmpty
      state = AsyncValue.data(user);
    } catch (e, stackTrace) {
      print("Signup failed with error: $e"); // Debug lỗi

      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      final user = await _authService.signin(
        email: email,
        password: password,
      );

      if (user.id.isNotEmpty) {
        state = AsyncValue.data(user);
      } else {
        throw Exception("Signin failed: Invalid user data");
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
