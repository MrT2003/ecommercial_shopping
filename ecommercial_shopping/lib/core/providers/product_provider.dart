import 'package:ecommercial_shopping/core/models/product.dart';
import 'package:ecommercial_shopping/core/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchProducts();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchProductsProvider = FutureProvider<List<Product>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) {
    return []; // Nếu chưa search gì thì trả về list rỗng
  }
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchProductsByName(query);
});
