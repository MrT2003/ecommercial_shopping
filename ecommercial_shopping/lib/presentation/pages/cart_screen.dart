import 'package:ecommercial_shopping/presentation/pages/checkout_screen.dart';
import 'package:ecommercial_shopping/presentation/widgets/cart/_build_cart_item.dart';
import 'package:ecommercial_shopping/presentation/widgets/cart/_build_summary_row.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "My Cart",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery Address',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Change',
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.deepOrange.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.location_on,
                                  color: Colors.deepOrange),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Home',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '57/1/3, Truong Dang Que, Phuong 1, Go Vap',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Order Items',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  BuildCartItem(
                    name: 'Chicken Burger',
                    description: 'Large size - Extra cheese',
                    price: '12.99',
                    imageUrl: 'assets/images/salad.jpg',
                    quantity: 1,
                    onIncrement: () {
                      // Tăng số lượng
                      print('Tăng số lượng Chicken Burger');
                    },
                    onDecrement: () {
                      // Giảm số lượng
                      print('Giảm số lượng Chicken Burger');
                    },
                  ),
                  BuildCartItem(
                    name: 'Chicken Burger',
                    description: 'Large size - Extra cheese',
                    price: '12.99',
                    imageUrl: 'assets/images/salad.jpg',
                    quantity: 1,
                    onIncrement: () {
                      // Tăng số lượng
                      print('Tăng số lượng Chicken Burger');
                    },
                    onDecrement: () {
                      // Giảm số lượng
                      print('Giảm số lượng Chicken Burger');
                    },
                  ),
                  BuildCartItem(
                    name: 'Chicken Burger',
                    description: 'Large size - Extra cheese',
                    price: '12.99',
                    imageUrl: 'assets/images/salad.jpg',
                    quantity: 1,
                    onIncrement: () {
                      // Tăng số lượng
                      print('Tăng số lượng Chicken Burger');
                    },
                    onDecrement: () {
                      // Giảm số lượng
                      print('Giảm số lượng Chicken Burger');
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                BuildSummaryRow(
                  label: 'Subtotal',
                  amount: '28.94',
                ),
                SizedBox(height: 8),
                BuildSummaryRow(
                  label: 'Delivery Fee',
                  amount: '2.00',
                ),
                SizedBox(height: 8),
                BuildSummaryRow(
                  label: 'Tax',
                  amount: '1.85',
                ),
                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 8),
                BuildSummaryRow(
                  label: 'Total',
                  amount: '32.79',
                  isTotal: true,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutScreen())),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Proceed to Checkout",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
