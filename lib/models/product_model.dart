import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final int price;
  final String image;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  Product copyWith({String? id, String? name, int? price, String? image}) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [id, name, price, image];

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price, 'image': image};
  }

  static Product fromMap(Map<String, dynamic> map) {
    final dynamic p = map['price'];
    final int parsedPrice = p is int
        ? p
        : (p is String ? int.tryParse(p) ?? 0 : 0);

    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      price: parsedPrice,
      image: map['image'] as String,
    );
  }
}
