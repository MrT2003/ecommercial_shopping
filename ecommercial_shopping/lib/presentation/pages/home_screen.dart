import 'package:ecommercial_shopping/presentation/pages/cart_screen.dart';
import 'package:ecommercial_shopping/presentation/pages/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    _buildCategoryChip("All", true),
                    _buildCategoryChip("Pizza", false),
                    _buildCategoryChip("Burger", false),
                    _buildCategoryChip("Shawarma", false),
                    _buildCategoryChip("Salad", false),
                    _buildCategoryChip("Wings", false),

                    //     _buildCategoryChip(
                    //   label: "All",
                    //   isSelected: selectedCategory == "All",
                    //   onTap: () {
                    //     setState(() {
                    //       selectedCategory = "All";
                    //     });
                    //   },
                    // ),
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
                    _buildFoodCard("Pepperoni Pizza", "12.99",
                        "assets/images/pizza.jpg", "4.5", "20-25 min", context),
                    _buildFoodCard(
                        "Pepperoni Pizza",
                        "12.99",
                        "assets/images/burger.jpg",
                        "4.5",
                        "20-25 min",
                        context),
                    _buildFoodCard("Pepperoni Pizza", "12.99",
                        "assets/images/salad.jpg", "4.5", "20-25 min", context),
                    _buildFoodCard("Pepperoni Pizza", "12.99",
                        "assets/images/wings.jpg", "4.5", "20-25 min", context),
                    _buildFoodCard(
                        "Pepperoni Pizza",
                        "12.99",
                        "assets/images/shawarma.jpg",
                        "4.5",
                        "20-25 min",
                        context),

                    //                         _buildFoodCard(
                    //   name: "Pepperoni Pizza",
                    //   price: "12.99",
                    //   imageUrl: "assets/images/pizza.jpg",
                    //   rating: "4.5",
                    //   deliveryTime: "20-25 min",
                    //   destinationScreen: ProductDetailScreen(),
                    // ),
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
              _buildRecommendItem("Pepperoni Pizza", "12.99",
                  "assets/images/shawarma.jpg", "4.5", "20-25 min"),
              _buildRecommendItem("Pepperoni Pizza", "12.99",
                  "assets/images/wings.jpg", "4.5", "20-25 min"),

              //            _buildRecommendItem(
              //   name: "Pepperoni Pizza",
              //   price: "12.99",
              //   imageUrl: "assets/images/shawarma.jpg",
              //   rating: "4.5",
              //   deliveryTime: "20-25 min",
              //   onTap: () {
              //     // Xử lý khi nhấp vào toàn bộ item
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => ProductDetailScreen()),
              //     );
              //   },
              //   onAddTap: () {
              //     // Xử lý khi nhấp vào nút thêm
              //     print("Add to cart: Pepperoni Pizza");
              //     // Hoặc có thể thêm vào giỏ hàng
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
          backgroundColor: isSelected ? Colors.deepOrange : Colors.white,
          label: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          )),
    );
  }

  Widget _buildRecommendItem(String name, String price, String imageUrl,
      String rating, String deliveryTime) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            )
          ]),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20),
            ),
            child: Image.asset(
              imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Text(
                        " $rating",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " - $deliveryTime",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$$price",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFoodCard(String name, String price, String imageUrl,
      String rating, String deliveryTime, BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(),
          )),
      child: Container(
        width: 180,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      Text(
                        " $rating",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " - $deliveryTime",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$$price",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
