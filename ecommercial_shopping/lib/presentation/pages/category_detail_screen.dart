import 'package:ecommercial_shopping/core/models/ppl.dart';
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
  final List<PplDrinkRecommendation>? pplResults; // 👈 thêm

  const CategoryDetailScreen({
    super.key,
    required this.categoryName,
    this.pplResults, // 👈 thêm
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final userId = authState.when(
      data: (user) => user?.userId ?? '',
      loading: () => '',
      error: (_, __) => '',
    );

    // ✅ CASE 1: đi từ PPL (voice) sang, dùng list pplResults
    if (pplResults != null) {
      final drinks = pplResults!;

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
        body: GridView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: drinks.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final drink = drinks[index];

            // Ở đây mình dùng UI card đơn giản cho đồ uống từ PPL
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: InkWell(
                onTap: () {
                  // TODO: nếu sau này bạn muốn bấm vào để xem chi tiết,
                  // có thể map id từ drink sang Product rồi push ProductDetailScreen
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: drink.imageURL != null
                            ? Image.network(
                                drink.imageURL!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.local_cafe, size: 32),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        drink.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        drink.drinkCategory,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${drink.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                          if (drink.temperatures.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.deepOrange.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                drink.temperatures.first,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    // ✅ CASE 2: flow cũ – filter theo categoryName
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
