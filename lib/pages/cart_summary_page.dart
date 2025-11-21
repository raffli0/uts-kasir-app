import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_cubit.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Hero(
        tag: product.id,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text('Harga: Rp ${product.price}'),
              const SizedBox(height: 10),
              const Divider(),
              Text(
                'Gambar: ${product.image.isEmpty ? "(tidak ada)" : product.image}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartSummaryPage extends StatelessWidget {
  const CartSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: BlocBuilder<CartCubit, List<Product>>(
        builder: (context, products) {
          if (products.isEmpty) {
            return const Center(child: Text('Keranjang kosong'));
          }

          final total = products.fold<int>(0, (s, p) => s + p.price);

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: products.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final p = products[index];
                    return ListTile(
                      leading: p.image.isNotEmpty
                          ? SizedBox(
                              width: 56,
                              height: 56,
                              child: Image.network(p.image, fit: BoxFit.cover),
                            )
                          : const CircleAvatar(child: Icon(Icons.shopping_bag)),
                      title: Text(p.name),
                      subtitle: Text('Rp ${p.price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            context.read<CartCubit>().removeFromCart(p.id),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total', style: TextStyle(fontSize: 16)),
                        Text(
                          'Rp $total',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // perform checkout (here just clear cart)
                        context.read<CartCubit>().clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Checkout selesai — keranjang dikosongkan',
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
