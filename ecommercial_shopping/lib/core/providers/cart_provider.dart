import 'package:ecommercial_shopping/core/models/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommercial_shopping/core/services/cart_service.dart';

final cartServiceProvider = Provider<CartService>((ref) => CartService());

// Add product in Cart
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

// Fetch Products in Cart
final cartProvider = FutureProvider.autoDispose<List<Cart>>((ref) async {
  final cartService = ref.read(cartServiceProvider);
  return cartService.fetchProductsInCart();
});

// Get total price for a specific user
final cartTotalPriceProvider =
    FutureProvider.family.autoDispose<double, String>((ref, userId) async {
  final cartService = ref.read(cartServiceProvider);
  return cartService.getTotalPrice(userId);
});

// // Get user's cart with total price
// final userCartProvider =
//     FutureProvider.family.autoDispose<Cart?, String>((ref, userId) async {
//   final cartService = ref.read(cartServiceProvider);
//   return cartService.getUserCart(userId);
// });

// // Update cart item
// final cartUpdateProvider = FutureProvider.family
//     .autoDispose<void, Map<String, dynamic>>((ref, params) async {
//   final cartService = ref.read(cartServiceProvider);
//   await cartService.updateCartItem(
//     userId: params['userId'],
//     productId: params['productId'],
//     quantity: params['quantity'],
//   );

//   // Invalidate cart providers to refresh data
//   ref.invalidate(cartProvider);
//   ref.invalidate(userCartProvider(params['userId']));
//   ref.invalidate(cartTotalPriceProvider(params['userId']));
// });

// // Remove item from cart
// final cartRemoveProvider = FutureProvider.family
//     .autoDispose<bool, Map<String, dynamic>>((ref, params) async {
//   final cartService = ref.read(cartServiceProvider);
//   final result = await cartService.removeFromCart(
//     userId: params['userId'],
//     productId: params['productId'],
//   );

//   if (result) {
//     // Invalidate cart providers to refresh data
//     ref.invalidate(cartProvider);
//     ref.invalidate(userCartProvider(params['userId']));
//     ref.invalidate(cartTotalPriceProvider(params['userId']));
//   }

//   return result;
// });
