import 'package:ecommercial_shopping/core/providers/auth_provider.dart';
import 'package:ecommercial_shopping/core/providers/product_provider.dart';
import 'package:ecommercial_shopping/presentation/pages/cart_screen.dart';
import 'package:ecommercial_shopping/presentation/pages/product_detail_screen.dart';
import 'package:ecommercial_shopping/presentation/widgets/home/_build_food_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryDetailScreen extends ConsumerWidget {
  final String categoryName;

  const CategoryDetailScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final userId = authState.when(
      data: (user) => user?.userId ?? '',
      loading: () => '',
      error: (_, __) => '',
    );

    final productAsync = ref.watch(productsProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(categoryName),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.deepOrange.shade50,
              child: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                ),
                icon: Icon(Icons.shopping_cart),
                color: Colors.deepOrange,
              ),
            ),
          )
        ],
      ),
      body: productAsync.when(
        data: (products) {
          final filteredProducts = products.where((product) {
            return product.category.any(
              (cat) => cat.toLowerCase() == categoryName.toLowerCase(),
            );
          }).toList();

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: filteredProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return BuildFoodCard(
                userId: userId,
                id: product.id,
                name: product.name,
                price: product.price,
                imageUrl: product.imageUrl,
                rating: product.rates,
                deliveryTime: product.preparationTime,
                destinationScreen: ProductDetailScreen(product: product),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
