import 'package:ecommercial_shopping/core/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuildFoodCard extends ConsumerWidget {
  final String userId;
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final double rating;
  final String deliveryTime;
  final VoidCallback? onTap;
  final Widget? destinationScreen;

  const BuildFoodCard({
    super.key,
    required this.userId,
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    this.onTap,
    this.destinationScreen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
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
        width: 180,
        margin: EdgeInsets.only(right: 16, bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // color: Colors.grey.withOpacity(0.1),
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
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
                    overflow: TextOverflow
                        .ellipsis, // Thêm dấu "..." khi text quá dài
                    maxLines: 1, // Giới hạn số dòng là 1
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
                        width: 40,
                        height: 40,
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
                              'image': imageUrl,
                            }).future);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(result
                                  ? 'Thêm thành công!'
                                  : 'Thêm thất bại.'),
                            ));
                          },
                        ),
                      ),
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
