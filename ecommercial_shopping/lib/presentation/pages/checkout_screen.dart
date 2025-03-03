import 'package:ecommercial_shopping/presentation/widgets/checkout/_build_order_item.dart';
import 'package:ecommercial_shopping/presentation/widgets/checkout/_build_payment_option.dart';
import 'package:ecommercial_shopping/presentation/widgets/checkout/_build_section_card.dart';
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
                              _buildTextField('Cart Number',
                                  'XXXX XXXX XXXX XXXX', Icons.credit_card),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                      child: _buildTextField('Expiry Date',
                                          'MM/YY', Icons.calendar_today)),
                                  SizedBox(width: 16),
                                  Expanded(
                                      child: _buildTextField(
                                          'CVV', 'XXX', Icons.lock_outline)),
                                ],
                              ),
                              SizedBox(height: 16),
                              _buildTextField(
                                  'Card Holder Name',
                                  'Enter card holder name',
                                  Icons.person_outlined)
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
                    _buildSummaryRow('Subtotal', '28.94'),
                    SizedBox(height: 8),
                    _buildSummaryRow('Delivery Fee', '2.50'),
                    SizedBox(height: 8),
                    _buildSummaryRow('Tax', '2.99'),
                    Divider(height: 24),
                    _buildSummaryRow('Total', '34.32', isTotal: true),
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

  Widget _buildOrderItem(String name, String price, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
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
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        )
      ],
    );
  }

  Widget _buildPaymentOption(int index, String title, IconData icon) {
    final isSelected = _selectedPaymentMethod == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPaymentMethod = index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.deepOrange : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.deepOrange : Colors.grey.shade300,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, color: Colors.deepOrange),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              )),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? Colors.black : Colors.grey[600],
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          '\$$amount',
          style: TextStyle(
            color: isTotal ? Colors.deepOrange : Colors.black,
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
