import 'package:ecommercial_shopping/core/providers/auth_provider.dart';
import 'package:ecommercial_shopping/core/providers/category_provider.dart';
import 'package:ecommercial_shopping/core/providers/product_provider.dart';
import 'package:ecommercial_shopping/presentation/pages/cart_screen.dart';
import 'package:ecommercial_shopping/presentation/pages/product_detail_screen.dart';
import 'package:ecommercial_shopping/presentation/widgets/home/_build_category_chip.dart';
import 'package:ecommercial_shopping/presentation/widgets/home/_build_food_card.dart';
import 'package:ecommercial_shopping/presentation/widgets/home/_build_recommend_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final userId = authState.when(
      data: (user) => user?.userId ?? '',
      loading: () => '',
      error: (_, __) => '',
    );

    final productAsync = ref.watch(productsProvider);
    final categoryAsync = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: Colors.black,
        ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delicious Food",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Delivered To Your Door",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                      )
                    ]),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search your favourite food",
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.filter_alt),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: categoryAsync.when(
                  data: (categories) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return BuildCategoryChip(
                        label: category.name,
                        isSelected: selectedCategory == category.name,
                        onTap: () {
                          ref.read(selectedCategoryProvider.notifier).state =
                              category.name;
                        },
                      );
                    },
                  ),
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Popular Now",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 280,
                child: productAsync.when(
                  data: (products) {
                    final productsToShow = products.take(10).toList();
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productsToShow.length,
                      itemBuilder: (context, index) {
                        final product = productsToShow[index];
                        return BuildFoodCard(
                          userId: userId,
                          id: product.id,
                          name: product.name,
                          price: product.price.toString(),
                          imageUrl: product.imageUrl,
                          rating: product.rates.toString(),
                          deliveryTime: product.preparationTime,
                          destinationScreen:
                              ProductDetailScreen(product: product),
                        );
                      },
                    );
                  },
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Recommended",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 500,
                child: SingleChildScrollView(
                  child: productAsync.when(
                    data: (products) => Column(
                      children: products
                          .take(4)
                          .map((product) => BuildRecommendItem(
                                name: product.name,
                                price: product.price.toString(),
                                imageUrl: product.imageUrl,
                                rating: product.rates.toString(),
                                deliveryTime: product.preparationTime,
                                destinationScreen:
                                    ProductDetailScreen(product: product),
                              ))
                          .toList(),
                    ),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (error, stack) =>
                        Center(child: Text('Error: $error')),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
