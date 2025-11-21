import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_cubit.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
import 'cart_summary_page.dart';
import 'cart_grid_page.dart';

class CartHomePage extends StatefulWidget {
  const CartHomePage({super.key});

  @override
  State<CartHomePage> createState() => _CartHomePageState();
}

class _CartHomePageState extends State<CartHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  void _addProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama Produk'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Harga (angka)'),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(
                labelText: 'URL Gambar (opsional)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                context.read<CartCubit>().addToCart(
                  nameController.text,
                  priceController.text,
                  imageController.text,
                );
                nameController.clear();
                priceController.clear();
                imageController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir Sederhana'),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TodoGridPage()),
            ),
          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addProductDialog(context),
        child: const Icon(Icons.add_shopping_cart),
      ),
      body: BlocBuilder<CartCubit, List<Product>>(
        builder: (context, products) {
          if (products.isEmpty) {
            return const Center(child: Text('Belum ada produk'));
          }

          return SafeArea(
            bottom: true,
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
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
            ),
          );
        },
      ),
    );
  }
}
