import 'package:ecommercial_shopping/core/models/ppl.dart';
import 'package:ecommercial_shopping/core/providers/product_provider.dart';
import 'package:ecommercial_shopping/presentation/pages/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PplResultScreen extends ConsumerWidget {
  final String queryText;
  final List<PplDrinkRecommendation> results;

  const PplResultScreen({
    super.key,
    required this.queryText,
    required this.results,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('The result for "$queryText"'),
        centerTitle: true,
      ),
      body: results.isEmpty
          ? const Center(
              child: Text('No matching products found 🤔'),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: results.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final drink = results[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      // Khi bấm vào 1 drink → tìm Product tương ứng rồi push detail
                      final productsAsync = ref.read(productsProvider);

                      productsAsync.when(
                        data: (products) {
                          // Tìm product có id trùng với drink.id
                          var foundProduct;
                          for (final p in products) {
                            if (p.id == drink.id) {
                              foundProduct = p;
                              break;
                            }
                          }

                          if (foundProduct == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No matching product found 🤔'),
                              ),
                            );
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(
                                product: foundProduct,
                              ),
                            ),
                          );
                        },
                        loading: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Loading product list...'),
                            ),
                          );
                        },
                        error: (err, _) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error loading product: $err'),
                            ),
                          );
                        },
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ảnh
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: drink.imageURL != null &&
                                    drink.imageURL!.isNotEmpty
                                ? Image.network(
                                    drink.imageURL!,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(
                                        Icons.local_cafe,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                          ),
                        ),

                        // Tên
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Text(
                            drink.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // Category / drinkCategory
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            drink.drinkCategory.isNotEmpty
                                ? drink.drinkCategory
                                : (drink.category.isNotEmpty
                                    ? drink.category
                                    : 'Drink'),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Giá + nhiệt độ
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${drink.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              if (drink.temperatures.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange.shade50,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    drink.temperatures.first,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
