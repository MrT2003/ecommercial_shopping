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
    final productAsync = ref.watch(productsProvider);
    String selectedCategory = "All";

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
              // SizedBox(
              //   height: 40,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       BuildCategoryChip(
              //         label: "All",
              //         isSelected: selectedCategory == "All",
              //         onTap: () {
              //           setState(() {
              //             selectedCategory = "All";
              //           });
              //         },
              //       ),
              //       BuildCategoryChip(
              //         label: "Pizza",
              //         isSelected: selectedCategory == "Pizza",
              //         onTap: () {
              //           setState(() {
              //             selectedCategory = "Pizza";
              //           });
              //         },
              //       ),
              //       BuildCategoryChip(
              //         label: "Burger",
              //         isSelected: selectedCategory == "Burger",
              //         onTap: () {
              //           setState(() {
              //             selectedCategory = "Burger";
              //           });
              //         },
              //       ),
              //       BuildCategoryChip(
              //         label: "Shawarma",
              //         isSelected: selectedCategory == "Shawarma",
              //         onTap: () {
              //           setState(() {
              //             selectedCategory = "Shawarma";
              //           });
              //         },
              //       ),
              //       BuildCategoryChip(
              //         label: "Salad",
              //         isSelected: selectedCategory == "Salad",
              //         onTap: () {
              //           setState(() {
              //             selectedCategory = "Salad";
              //           });
              //         },
              //       ),
              //       BuildCategoryChip(
              //         label: "Wings",
              //         isSelected: selectedCategory == "Wings",
              //         onTap: () {
              //           setState(() {
              //             selectedCategory = "Wings";
              //           });
              //         },
              //       ),
              //     ],
              //   ),
              // ),
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
                height: 240,
                child: productAsync.when(
                  data: (products) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return BuildFoodCard(
                        name: product.name,
                        price: product.price.toString(),
                        imageUrl: product.imageUrl,
                        rating: product.rates.toString(),
                        deliveryTime: product.preparationTime,
                        destinationScreen: const ProductDetailScreen(),
                      );
                    },
                  ),
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
              // BuildRecommendItem(
              //   name: "Pepperoni Pizza",
              //   price: "12.99",
              //   imageUrl: "assets/images/shawarma.jpg",
              //   rating: "4.5",
              //   deliveryTime: "20-25 min",
              //   onTap: () {
              //     // Xử lý khi nhấp vào toàn bộ item
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => ProductDetailScreen()),
              //     );
              //   },
              //   // onAddTap: () {
              //   //   // Xử lý khi nhấp vào nút thêm
              //   //   print("Add to cart: Pepperoni Pizza");
              //   //   // Hoặc có thể thêm vào giỏ hàng
              //   // },
              // ),
              SizedBox(
                height: 100,
                child: productAsync.when(
                  data: (products) => ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return BuildRecommendItem(
                        name: product.name,
                        price: product.price.toString(),
                        imageUrl: product.imageUrl,
                        rating: product.rates.toString(),
                        deliveryTime: product.preparationTime,
                        destinationScreen: const ProductDetailScreen(),
                      );
                    },
                  ),
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
