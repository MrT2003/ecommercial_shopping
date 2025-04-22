import 'package:ecommercial_shopping/core/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuildRecommendItem extends ConsumerWidget {
  final String userId;
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final double rating;
  final String deliveryTime;
  final VoidCallback? onTap;
  final VoidCallback? onAddTap;
  final Widget? destinationScreen;

  const BuildRecommendItem({
    super.key,
    required this.userId,
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    this.onTap,
    this.onAddTap,
    this.destinationScreen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap ??
          () {
            if (destinationScreen != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => destinationScreen!,
                ),
              );
            }
          },
      child: Container(
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
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20),
              ),
              child: Image.network(
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
                        GestureDetector(
                          onTap: onAddTap,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.add), // Đúng định dạng
                              color: Colors.white,
                              iconSize: 20, // Sử dụng iconSize thay vì size
                              onPressed: () async {
                                print("DEBUG: Giá trị price nhận được: $price");
                                final result = await ref.read(cartAddProvider({
                                  'userId': userId,
                                  'productId': id,
                                  'quantity': 1,
                                  'price': price,
                                  'name': name,
                                }).future);

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(result
                                      ? 'Thêm thành công!'
                                      : 'Thêm thất bại.'),
                                ));
                              },
                            ),
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
      ),
    );
  }
}
