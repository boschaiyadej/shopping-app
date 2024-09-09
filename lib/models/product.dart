class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String image;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      required this.tags,
      required this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Title',
      description: json['description'] ?? 'No description available',
      category: json['category'] ?? 'Unknown Category',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      image: json['image'] ?? 'https://via.placeholder.com/150',
    );
  }
}
