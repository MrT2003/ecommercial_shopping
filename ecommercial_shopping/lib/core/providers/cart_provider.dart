import 'package:ecommercial_shopping/core/models/cart.dart';
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
    name: params['name'],
    image: params['image'],
  );
});

final cartProvider = FutureProvider.autoDispose<List<Cart>>((ref) async {
  final cartService = ref.read(cartServiceProvider);
  return cartService.fetchProductsInCart();
});

final cartTotalPriceProvider =
    FutureProvider.family.autoDispose<double, String>((ref, userId) async {
  final cartService = ref.read(cartServiceProvider);
  return cartService.getTotalPrice(userId);
});
