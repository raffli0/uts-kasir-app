import 'package:bloc/bloc.dart';
import '../models/product_model.dart';

class CartCubit extends Cubit<List<Product>> {
  CartCubit() : super([]);

  // menambahkan produk ke keranjang
  void addToCart(String title, String price, String image) {
    final parsedPrice = int.tryParse(price) ?? 0;
    final newProduct = Product(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: title,
      price: parsedPrice,
      image: image,
    );
    emit([...state, newProduct]);
  }

  // void toggleTodo(String id) {
  //   emit(
  //     state.map((todo) {
  //       if (todo.id == id) {
  //         return todo.copyWith(isDone: !todo.isDone);
  //       }
  //       return todo;
  //     }).toList(),
  //   );
  // }

  // menghapus produk dari keranjang
  void removeFromCart(String id) {
    emit(state.where((product) => product.id != id).toList());
  }

  /// Menghapus semua item dari keranjang.
  void clearCart() {
    emit([]);
  }

  /// Memperbarui jumlah item untuk produk tertentu.
  void updateQuantity(String id, int newPrice) {
    emit(
      state.map((product) {
        if (product.id == id) {
          return product.copyWith(price: newPrice);
        }
        return product;
      }).toList(),
    );
  }

  // menghitung total item dalam keranjang
  int getTotalItems() {
    return state.length;
  }

  /// Menghitung total harga (jumlah dari field `price`) untuk semua item.
  int getTotalPrice() {
    return state.fold<int>(0, (sum, product) => sum + product.price);
  }
}
