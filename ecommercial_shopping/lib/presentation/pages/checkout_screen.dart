import 'package:ecommercial_shopping/presentation/widgets/cart/_build_summary_row.dart';
import 'package:ecommercial_shopping/presentation/widgets/checkout/_build_order_item.dart';
import 'package:ecommercial_shopping/presentation/widgets/checkout/_build_payment_option.dart';
import 'package:ecommercial_shopping/presentation/widgets/checkout/_build_section_card.dart';
import 'package:ecommercial_shopping/presentation/widgets/checkout/_build_text_field.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPaymentMethod = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      BuildSectionCard(
                        title: 'Order Summary',
                        content: Column(
                          children: [
                            BuildOrderItem(
                              name: 'Pepperoni Pizza',
                              price: '\$12.99',
                              description: 'Larger - Extra Cheese',
                            ),
                            Divider(height: 20),
                            BuildOrderItem(
                              name: 'Chicken Burger',
                              price: '\$8.99',
                              description: 'Larger - Extra Cheese',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      BuildSectionCard(
                        title: 'Payment Method',
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                BuildPaymentOption(
                                  index: 0,
                                  title: 'Credit Card',
                                  icon: Icons.credit_card,
                                  selectedPaymentMethod: _selectedPaymentMethod,
                                  onPaymentMethodChanged: (index) {
                                    setState(
                                        () => _selectedPaymentMethod = index);
                                  },
                                ),
                                SizedBox(width: 12),
                                BuildPaymentOption(
                                  index: 1,
                                  title: 'Paypal',
                                  icon: Icons.payment,
                                  selectedPaymentMethod: _selectedPaymentMethod,
                                  onPaymentMethodChanged: (index) {
                                    setState(
                                        () => _selectedPaymentMethod = index);
                                  },
                                ),
                                SizedBox(width: 12),
                                BuildPaymentOption(
                                  index: 2,
                                  title: 'COD',
                                  icon: Icons.home_filled,
                                  selectedPaymentMethod: _selectedPaymentMethod,
                                  onPaymentMethodChanged: (index) {
                                    setState(
                                        () => _selectedPaymentMethod = index);
                                  },
                                ),
                              ],
                            ),
                            if (_selectedPaymentMethod == 0) ...[
                              SizedBox(height: 20),
                              BuildTextField(
                                label: "Cart Number",
                                hint: "XXXX XXXX XXXX XXXX",
                                icon: Icons.credit_card,
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: BuildTextField(
                                      label: "Expiry Date",
                                      hint: "MM/YY",
                                      icon: Icons.calendar_today,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: BuildTextField(
                                      label: "CVV",
                                      hint: "XXX",
                                      icon: Icons.lock_outline,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              BuildTextField(
                                label: "Card Holder Name",
                                hint: "Enter card holder name",
                                icon: Icons.person_outlined,
                              ),
                            ]
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      BuildSectionCard(
                        title: 'Additional Notes',
                        content: TextField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Add notes for your order (optional)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                      ),
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
                      amount: '2.50',
                    ),
                    SizedBox(height: 8),
                    BuildSummaryRow(
                      label: 'Tax',
                      amount: '2.99',
                    ),
                    Divider(height: 24),
                    BuildSummaryRow(
                      label: 'Total',
                      amount: '34.32',
                      isTotal: true,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "Place Order - \$34.32",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
