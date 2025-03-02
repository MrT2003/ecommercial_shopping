import 'package:ecommercial_shopping/presentation/pages/cart_screen.dart';
import 'package:ecommercial_shopping/presentation/pages/product_detail_screen.dart';
import 'package:ecommercial_shopping/presentation/widgets/home/_build_category_chip.dart';
import 'package:ecommercial_shopping/presentation/widgets/home/_build_food_card.dart';
import 'package:ecommercial_shopping/presentation/widgets/home/_build_recommend_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    BuildCategoryChip(
                      label: "All",
                      isSelected: selectedCategory == "All",
                      onTap: () {
                        setState(() {
                          selectedCategory = "All";
                        });
                      },
                    ),
                    BuildCategoryChip(
                      label: "Pizza",
                      isSelected: selectedCategory == "Pizza",
                      onTap: () {
                        setState(() {
                          selectedCategory = "Pizza";
                        });
                      },
                    ),
                    BuildCategoryChip(
                      label: "Burger",
                      isSelected: selectedCategory == "Burger",
                      onTap: () {
                        setState(() {
                          selectedCategory = "Burger";
                        });
                      },
                    ),
                    BuildCategoryChip(
                      label: "Shawarma",
                      isSelected: selectedCategory == "Shawarma",
                      onTap: () {
                        setState(() {
                          selectedCategory = "Shawarma";
                        });
                      },
                    ),
                    BuildCategoryChip(
                      label: "Salad",
                      isSelected: selectedCategory == "Salad",
                      onTap: () {
                        setState(() {
                          selectedCategory = "Salad";
                        });
                      },
                    ),
                    BuildCategoryChip(
                      label: "Wings",
                      isSelected: selectedCategory == "Wings",
                      onTap: () {
                        setState(() {
                          selectedCategory = "Wings";
                        });
                      },
                    ),
                  ],
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
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    BuildFoodCard(
                      name: "Pepperoni Pizza",
                      price: "12.99",
                      imageUrl: "assets/images/pizza.jpg",
                      rating: "4.5",
                      deliveryTime: "20-25 min",
                      destinationScreen: ProductDetailScreen(),
                    ),
                    BuildFoodCard(
                      name: "Pepperoni Pizza",
                      price: "12.99",
                      imageUrl: "assets/images/pizza.jpg",
                      rating: "4.5",
                      deliveryTime: "20-25 min",
                      destinationScreen: ProductDetailScreen(),
                    ),
                    BuildFoodCard(
                      name: "Pepperoni Pizza",
                      price: "12.99",
                      imageUrl: "assets/images/pizza.jpg",
                      rating: "4.5",
                      deliveryTime: "20-25 min",
                      destinationScreen: ProductDetailScreen(),
                    ),
                    BuildFoodCard(
                      name: "Pepperoni Pizza",
                      price: "12.99",
                      imageUrl: "assets/images/pizza.jpg",
                      rating: "4.5",
                      deliveryTime: "20-25 min",
                      destinationScreen: ProductDetailScreen(),
                    ),
                    BuildFoodCard(
                      name: "Pepperoni Pizza",
                      price: "12.99",
                      imageUrl: "assets/images/pizza.jpg",
                      rating: "4.5",
                      deliveryTime: "20-25 min",
                      destinationScreen: ProductDetailScreen(),
                    ),
                  ],
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
              BuildRecommendItem(
                name: "Pepperoni Pizza",
                price: "12.99",
                imageUrl: "assets/images/shawarma.jpg",
                rating: "4.5",
                deliveryTime: "20-25 min",
                onTap: () {
                  // Xử lý khi nhấp vào toàn bộ item
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetailScreen()),
                  );
                },
                // onAddTap: () {
                //   // Xử lý khi nhấp vào nút thêm
                //   print("Add to cart: Pepperoni Pizza");
                //   // Hoặc có thể thêm vào giỏ hàng
                // },
              ),
              BuildRecommendItem(
                name: "Pepperoni Pizza",
                price: "12.99",
                imageUrl: "assets/images/shawarma.jpg",
                rating: "4.5",
                deliveryTime: "20-25 min",
                onTap: () {
                  // Xử lý khi nhấp vào toàn bộ item
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetailScreen()),
                  );
                },
                // onAddTap: () {
                //   // Xử lý khi nhấp vào nút thêm
                //   print("Add to cart: Pepperoni Pizza");
                //   // Hoặc có thể thêm vào giỏ hàng
                // },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
