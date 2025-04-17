import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommercial_shopping/core/services/cart_service.dart';

final cartServiceProvider = Provider<CartService>((ref) => CartService());

final cartAddProvider = FutureProvider.family
    .autoDispose<bool, Map<String, dynamic>>((ref, params) async {
  final cartService = ref.read(cartServiceProvider);
  return cartService.addToCart(
    userId: params['userId'],
    productId: params['productId'],
    quantity: params['quantity'],
    price: params['price'],
  );
});
