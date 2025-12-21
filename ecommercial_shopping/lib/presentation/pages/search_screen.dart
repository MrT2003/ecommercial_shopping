import 'package:ecommercial_shopping/core/providers/product_provider.dart';
import 'package:ecommercial_shopping/core/providers/ppl_provider.dart';
import 'package:ecommercial_shopping/presentation/pages/product_detail_screen.dart';
import 'package:ecommercial_shopping/presentation/pages/ppl_resule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  Future<void> _runDslSearch(BuildContext context, WidgetRef ref) async {
    // Lấy text hiện tại từ searchQueryProvider
    final text = ref.read(searchQueryProvider).trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a sentence to search with DSL')),
      );
      return;
    }

    final pplState = ref.read(pplProvider);
    if (pplState.isLoading) return;

    final notifier = ref.read(pplProvider.notifier);
    await notifier.parseAndRecommend(text);

    final resultState = ref.read(pplProvider);
    if (!context.mounted) return;

    // 1) Lỗi cú pháp / lỗi backend
    if (resultState.error != null) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Syntax Error'),
          content: Text(resultState.error!),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // 2) Không tìm thấy sản phẩm
    if (resultState.recommendations.isEmpty) {
      await showDialog(
        context: context,
        builder: (ctx) => const AlertDialog(
          title: Text('Do not found'),
          content: Text(
            'There is no available product matching your request.\n'
            'Let\'s try:\n'
            '- "I want a cold coffee"\n'
            '- "Give a cold tea and medium sugar and large"',
          ),
        ),
      );
      return;
    }

    // 3) Có kết quả → sang PPL result screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PplResultScreen(
          queryText: text,
          results: resultState.recommendations,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProducts = ref.watch(searchProductsProvider);
    final pplState = ref.watch(pplProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.deepOrange,
        ),
        elevation: 0,
        title: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search name or type DSL...",
              prefixIcon: const Icon(Icons.search, color: Colors.deepOrange),
              // Nút DSL search
              suffixIcon: IconButton(
                onPressed: () => _runDslSearch(context, ref),
                icon: pplState.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.auto_awesome, color: Colors.deepOrange),
                tooltip: 'Smart search (DSL)',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.deepOrange,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.deepOrange,
                  width: 1.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
            // Gõ là search theo tên như cũ
            onChanged: (value) {
              ref.read(searchQueryProvider.notifier).state = value;
            },
          ),
        ),
      ),
      body: searchProducts.when(
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                child: ListTile(
                  leading: Image.network(
                    product.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text(
                    "\$${product.price.toStringAsFixed(2)}",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ProductDetailScreen(product: product),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          final tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          final offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
