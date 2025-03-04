import 'package:ecommercial_shopping/core/models/category.dart';
import 'package:ecommercial_shopping/core/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchCategories();
});
