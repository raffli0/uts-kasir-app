import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_cubit.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
import 'cart_summary_page.dart';

class TodoGridPage extends StatelessWidget {
  const TodoGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        actions: [
          BlocBuilder<CartCubit, List<Product>>(
            builder: (context, products) {
              final count = products.length;
              return IconButton(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_cart),
                    if (count > 0)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartSummaryPage()),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, List<Product>>(
        builder: (context, products) {
          if (products.isEmpty) {
            return const Center(child: Text('Tidak ada produk'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(product: product),
                  ),
                ),
                onDelete: () =>
                    context.read<CartCubit>().removeFromCart(product.id),
                onAddToCart: () => context.read<CartCubit>().addToCart(
                  product.name,
                  product.price.toString(),
                  product.image,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
