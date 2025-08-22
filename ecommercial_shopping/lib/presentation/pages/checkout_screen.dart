import 'package:ecommercial_shopping/core/models/cart.dart';
import 'package:ecommercial_shopping/core/providers/auth_provider.dart';
import 'package:ecommercial_shopping/core/providers/cart_provider.dart';
import 'package:ecommercial_shopping/core/utils/place_order.dart';
import 'package:ecommercial_shopping/presentation/widgets/cart/_build_summary_row.dart';
import 'package:ecommercial_shopping/presentation/widgets/checkout/_build_order_item.dart';
import 'package:ecommercial_shopping/presentation/widgets/checkout/_build_payment_option.dart';
import 'package:ecommercial_shopping/presentation/widgets/checkout/_build_section_card.dart';
import 'package:ecommercial_shopping/presentation/widgets/checkout/_build_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  final Cart? cart;

  const CheckoutScreen({super.key, this.cart});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  int _selectedPaymentMethod = 0;
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final userId = authState.when(
      data: (user) => user?.userId ?? '',
      loading: () => '',
      error: (_, __) => '',
    );

    // Use passed cart or fetch from provider
    final cartAsync = widget.cart != null
        ? AsyncValue.data([widget.cart!])
        : ref.watch(cartProvider);

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
      body: cartAsync.when(
        data: (carts) {
          final cart = carts.firstWhere(
            (cart) => cart.userId == userId,
            orElse: () => Cart(id: '', userId: '', items: [], totalPrice: 0),
          );

          final totalPrice = cart.totalPrice;

          return Stack(
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
                              children: cart.items.asMap().entries.map((entry) {
                                final item = entry.value;
                                final isLast =
                                    entry.key == cart.items.length - 1;

                                return Column(
                                  children: [
                                    BuildOrderItem(
                                      name: item.name,
                                      price:
                                          '\$${item.price.toStringAsFixed(2)}',
                                      description: 'Quantity: ${item.quantity}',
                                      imageUrl: item.image,
                                    ),
                                    if (!isLast) Divider(height: 20),
                                  ],
                                );
                              }).toList(),
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
                                    Expanded(
                                      child: BuildPaymentOption(
                                        index: 0,
                                        title: 'Credit Card',
                                        icon: Icons.credit_card,
                                        selectedPaymentMethod:
                                            _selectedPaymentMethod,
                                        onPaymentMethodChanged: (index) {
                                          setState(() =>
                                              _selectedPaymentMethod = index);
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: BuildPaymentOption(
                                        index: 1,
                                        title: 'COD',
                                        icon: Icons.local_shipping,
                                        selectedPaymentMethod:
                                            _selectedPaymentMethod,
                                        onPaymentMethodChanged: (index) {
                                          setState(() =>
                                              _selectedPaymentMethod = index);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                if (_selectedPaymentMethod == 0) ...[
                                  SizedBox(height: 20),
                                  BuildTextField(
                                    label: 'Card Number',
                                    hint: 'XXXX XXXX XXXX XXXX',
                                    icon: Icons.credit_card,
                                    controller: _cardNumberController,
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: BuildTextField(
                                          label: 'Expiry Date',
                                          hint: 'MM/YY',
                                          icon: Icons.calendar_today,
                                          controller: _expiryController,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: BuildTextField(
                                          label: 'CVV',
                                          hint: 'XXX',
                                          icon: Icons.lock_outline,
                                          controller: _cvvController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  BuildTextField(
                                    label: 'Card Holder Name',
                                    hint: 'Enter card holder name',
                                    icon: Icons.person_outlined,
                                    controller: _cardHolderController,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          BuildSectionCard(
                            title: 'Additional Notes',
                            content: TextField(
                              controller: _notesController,
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
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: Colors.deepOrange),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 150), // Space for bottom container
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BuildSummaryRow(
                        label: 'Total',
                        amount: totalPrice.toStringAsFixed(2),
                        isTotal: true,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: cart.items.isEmpty
                              ? null
                              : () => PlaceOrder.show(
                                    context: context,
                                    cart: cart,
                                    totalPrice: totalPrice,
                                    selectedPaymentMethod:
                                        _selectedPaymentMethod,
                                    cardNumberController: _cardNumberController,
                                    expiryController: _expiryController,
                                    cvvController: _cvvController,
                                    cardHolderController: _cardHolderController,
                                    onProcessOrder: () => _processOrder(
                                        context, cart, totalPrice),
                                  ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            disabledBackgroundColor: Colors.grey[300],
                            disabledForegroundColor: Colors.grey[600],
                          ),
                          child: Text(
                            cart.items.isEmpty
                                ? "No Items to Order"
                                : "Place Order - \$${totalPrice.toStringAsFixed(2)}",
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
              ),
            ],
          );
        },
        loading: () => Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Checkout'),
          ),
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Checkout'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text('Error loading checkout data'),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => ref.invalidate(cartProvider),
                  child: Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _processOrder(BuildContext context, Cart cart, double totalPrice) {
    // TODO: Implement actual order processing
    // This is where you'd call your order API

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Processing your order...'),
          ],
        ),
      ),
    );

    // Simulate order processing
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Order Successful!'),
            ],
          ),
          content: Text(
              'Your order has been placed successfully. You will receive a confirmation email shortly.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close success dialog
                Navigator.pop(context); // Go back to cart
                Navigator.pop(context); // Go back to previous screen
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              child: Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    });
  }
}
