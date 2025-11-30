class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final List<String>? sizes;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.sizes,
  });
  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
      sizes: data['sizes'] != null 
          ? List<String>.from(data['sizes'] as List)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
    };
    if (sizes != null && sizes!.isNotEmpty) {
      map['sizes'] = sizes!;
    }
    return map;
  }
}
